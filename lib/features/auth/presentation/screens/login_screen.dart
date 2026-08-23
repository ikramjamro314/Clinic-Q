import 'package:clinic_q/features/auth/presentation/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../app/app_routes.dart';
import '../../../../core/error/auth_exceptions.dart';
import '../widgets/login_signup/auth_header.dart';
import '../widgets/login_signup/auth_tab_toggle.dart';
import '../widgets/login_signup/or_divider.dart';
import '../widgets/login_signup/google_sign_in_button.dart';
import '../widgets/login_signup/sign_in_form.dart';
import '../widgets/login_signup/sign_up_form.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isSignUp = false;
  bool _isGoogleSignInPending = false;

  void _onToggle(bool isSignUp) {
    setState(() {
      _isSignUp = isSignUp;
    });
    ref.read(signInViewModelProvider.notifier).reset();
    ref.read(signUpViewModelProvider.notifier).reset();
  }

  Future<void> _handleGoogleSignIn() async {
    debugPrint('>>> LOGIN_SCREEN: Google button tapped');
    setState(() => _isGoogleSignInPending = true);
    try {
      debugPrint('>>> LOGIN_SCREEN: Calling signInWithGoogle()');
      await ref.read(authRepositoryProvider).signInWithGoogle();
      debugPrint('>>> LOGIN_SCREEN: signInWithGoogle() completed successfully');
      if (!mounted) return;

      context.go(AppRoutes.home);
    } catch (e) {
      if (!mounted) return;
      String message = 'Google Sign-In failed: $e';
      if (e is AuthException) {
        message = e.message;
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isGoogleSignInPending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthHeader(),
              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 20,
                      spreadRadius: 4,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Tab Selector - local state only
                    AuthTabToggle(isSignUp: _isSignUp, onToggle: _onToggle),
                    const SizedBox(height: 16),

                    // Show either SignInForm or SignUpForm based on tab
                    if (_isSignUp) const SignUpForm() else const SignInForm(),

                    const SizedBox(height: 16),

                    const OrDivider(),
                    const SizedBox(height: 16),

                    GoogleSignInButton(onPressed: _handleGoogleSignIn),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Bottom Disclaimer (Only on Sign Up view)
              if (_isSignUp)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text.rich(
                    TextSpan(
                      text: 'By continuing, you agree to ClinicQ\'s\n',
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 13,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Color(0xFF64748B)),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
