import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/app_routes.dart';
import '../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../core/widgets/inputs/clinicq_otp_field.dart';
import '../auth_providers.dart';
// ViewModel accessed via auth_providers.dart

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  int _resendTimerSeconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      6,
      (_) => TextEditingController(text: '\u200B'),
    );
    _focusNodes = List.generate(6, (_) => FocusNode());

    for (int i = 0; i < 6; i++) {
      final index = i;
      _controllers[index].addListener(_onCodeChanged);
      _focusNodes[index].addListener(_onFocusChanged);
    }
    _startResendTimer();
  }

  void _onCodeChanged() {
    final code = _controllers
        .map((c) => c.text.replaceAll('\u200B', ''))
        .join();
    ref.read(otpViewModelProvider.notifier).updateCode(code);
    setState(() {});
  }

  void _onFocusChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.removeListener(_onCodeChanged);
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.removeListener(_onFocusChanged);
      node.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendTimerSeconds = 60;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimerSeconds > 0) {
        setState(() {
          _resendTimerSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _handleOnChanged(int index, String value) {
    if (value == '') {
      _controllers[index].text = '\u200B';
      if (index > 0) {
        _controllers[index - 1].text = '\u200B';
        _focusNodes[index - 1].requestFocus();
      }
      return;
    }

    if (value == '\u200B') {
      // Case B: Backspace on filled field (value became just the placeholder "\u200B")
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
      return;
    }

    // Case C & D: Typed/overwrote a digit
    // Extract the last character (which is the newly entered digit)
    final String lastChar = value.substring(value.length - 1);

    // Set text to '\u200B' + lastChar
    _controllers[index].text = '\u200B$lastChar';

    // Move focus forward
    if (index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else {
      _focusNodes[index].unfocus();
      _handleVerify();
    }
  }

  Future<void> _handleVerify() async {
    final code = _controllers
        .map((c) => c.text.replaceAll('\u200B', ''))
        .join();

    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 6 digits.')),
      );
      return;
    }

    final success = await ref
        .read(otpViewModelProvider.notifier)
        .verifyEmailOtp(email: widget.email, code: code);

    if (!mounted) return;

    // Reset state and clear all controllers on verify click completion
    for (var controller in _controllers) {
      controller.text = '\u200B';
    }
    ref.read(otpViewModelProvider.notifier).updateCode('');
    _focusNodes[0].requestFocus();

    if (success) {
      final currentUser = ref.read(authRepositoryProvider).getCurrentUser();
      final hasProfile =
          currentUser != null &&
          currentUser.firstName != null &&
          currentUser.firstName!.trim().isNotEmpty;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Verification successful!')));

      if (hasProfile) {
        context.go(AppRoutes.home);
      } else {
        context.go(AppRoutes.profileDetails);
      }
    } else {
      final error = ref.read(otpViewModelProvider).errorMessage;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error ?? 'Verification failed.')));
    }
  }

  Future<void> _handleResend() async {
    if (_resendTimerSeconds > 0) return;

    // Reset state and clear all controllers on resend click
    for (var controller in _controllers) {
      controller.text = '\u200B';
    }
    ref.read(otpViewModelProvider.notifier).updateCode('');
    _focusNodes[0].requestFocus();

    final success = await ref
        .read(otpViewModelProvider.notifier)
        .resendEmailOtp(email: widget.email);

    if (success) {
      _startResendTimer();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP code resent successfully.')),
        );
      }
    }
  }

  String _formatTimer(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _maskContact(String contact) {
    if (contact.contains('@')) {
      final parts = contact.split('@');
      final local = parts[0];
      final domain = parts[1];
      if (local.length <= 4) {
        return '${local[0]}***@$domain';
      }
      return '${local.substring(0, 4)}***@$domain';
    } else {
      final clean = contact.replaceAll(RegExp(r'\s+'), '');
      if (clean.length <= 6) return contact;
      return '${clean.substring(0, 6)}***${clean.substring(clean.length - 4)}';
    }
  }

  bool get _isOtpComplete {
    return _controllers.every((c) => c.text.isNotEmpty);
  }

  Widget _buildIllustration() {
    return Container(
      width: 200,
      height: 200,
      decoration: const BoxDecoration(
        color: Color(0xFFF0FDFA), // Very light teal circle background
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: ClipOval(
        child: Image.asset(
          'assets/images/otp_illustration.png',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // Render the premium code-drawn fallback if the asset is missing or not registered yet
            return Stack(
              alignment: Alignment.center,
              children: [
                // Circular gradient inside
                Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFDBEAFE), Color(0xFFECFDF5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                // Tilted 3D phone representation
                Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(-0.2)
                    ..rotateY(0.3)
                    ..rotateZ(-0.15),
                  alignment: FractionalOffset.center,
                  child: Container(
                    width: 70,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF14B8A6), // Turquoise / Teal body
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(4, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 58,
                      height: 108,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F766E).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                // Glass envelope
                Positioned(
                  top: 70,
                  left: 65,
                  child: Container(
                    width: 44,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: const Icon(
                      Icons.mail_rounded,
                      color: Color(0xFF14B8A6),
                      size: 20,
                    ),
                  ),
                ),
                // Lock on envelope
                Positioned(
                  top: 64,
                  left: 92,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0EA5E9), // primaryBlue lock badge
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_rounded,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                ),
                // Plus icon
                Positioned(
                  bottom: 50,
                  right: 50,
                  child: Icon(
                    Icons.add_circle,
                    color: const Color(0xFF0EA5E9).withOpacity(0.9),
                    size: 28,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(otpViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.login);
            }
          },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      // Top illustration image
                      Center(child: _buildIllustration()),
                      const SizedBox(height: 36),

                      // Header Text
                      const Text(
                        'Verify your email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                          fontSize: 24,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Enter the 6-digit code we sent to\n',
                            ),
                            TextSpan(
                              text: _maskContact(widget.email),
                              style: const TextStyle(
                                color: Color(0xFF2563EB),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Redesigned Rounded OTP fields
                      ClinicQOtpField(
                        controllers: _controllers,
                        focusNodes: _focusNodes,
                        onChanged: _handleOnChanged,
                        activeColor: const Color(0xFF2563EB),
                      ),
                      const SizedBox(height: 36),

                      // Resend Code Now link
                      GestureDetector(
                        onTap: _resendTimerSeconds == 0 ? _handleResend : null,
                        child: Column(
                          children: [
                            const Text(
                              "Didn't receive the code?",
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _resendTimerSeconds == 0
                                  ? 'Resend Code Now'
                                  : 'Resend in (${_formatTimer(_resendTimerSeconds)})',
                              style: TextStyle(
                                color: _resendTimerSeconds == 0
                                    ? const Color(0xFF2563EB)
                                    : const Color(0xFF94A3B8),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Verify button (vibrant teal button)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ClinicQButton(
                          label: 'Verify',
                          onPressed: (_isOtpComplete && !state.isLoading)
                              ? _handleVerify
                              : null,
                          isLoading: state.isLoading,
                          backgroundColor: const Color(0xFF14B8A6), // teal
                          textColor: Colors.white,
                          borderRadius: 12,
                          height: 56,
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
