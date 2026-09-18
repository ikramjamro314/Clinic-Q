import 'package:clinic_q/features/profile/presentation/profile_providers.dart';
import 'package:clinic_q/features/home/presentation/home_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../app/app_routes.dart';
import '../../../../../core/widgets/buttons/clinicq_button.dart';
import '../../../../../core/widgets/inputs/clinicq_text_field.dart';
import '../../auth_providers.dart';

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm({super.key});

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(signInViewModelProvider);
    _emailController = TextEditingController(text: state.email);
    _passwordController = TextEditingController(text: state.password);

    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.removeListener(_onEmailChanged);
    _passwordController.removeListener(_onPasswordChanged);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    ref
        .read(signInViewModelProvider.notifier)
        .updateEmail(_emailController.text);
  }

  void _onPasswordChanged() {
    ref
        .read(signInViewModelProvider.notifier)
        .updatePassword(_passwordController.text);
  }

  void _showToast(BuildContext context, String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError
                  ? Icons.error_outline_rounded
                  : Icons.check_circle_outline_rounded,
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
        backgroundColor: isError
            ? const Color(0xFFEF4444)
            : const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    final success = await ref.read(signInViewModelProvider.notifier).submit();
    if (!mounted) return;

    if (success) {
      // Clear sensitive fields before navigating away
      _emailController.clear();
      _passwordController.clear();

      ref.invalidate(profileViewModelProvider);
      ref.invalidate(homeViewModelProvider);
      ref.read(hasProfileProvider.notifier).setState(null);

      context.go(AppRoutes.home);
    } else {
      final error = ref.read(signInViewModelProvider).errorMessage;
      _showToast(
        context,
        error ?? 'Sign in failed. Please try again.',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signInViewModelProvider, (previous, next) {
      if (next.email != _emailController.text) {
        _emailController.value = TextEditingValue(
          text: next.email,
          selection: TextSelection.collapsed(offset: next.email.length),
        );
      }
      if (next.password != _passwordController.text) {
        _passwordController.value = TextEditingValue(
          text: next.password,
          selection: TextSelection.collapsed(offset: next.password.length),
        );
      }
    });

    final state = ref.watch(signInViewModelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Headings
        const Text(
          'Welcome Back',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Log in to manage your appointments',
          style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
        ),

        const SizedBox(height: 20),

        // Email Address Label and Field
        const Text(
          'Email Address',
          style: TextStyle(
            color: Color(0xFF64748B),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        ClinicQTextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          hintText: 'name@example.com',
          prefixIcon: Icons.email_outlined,
          fillColor: Colors.white,
        ),
        const SizedBox(height: 16),

        // Password Label and Field
        const Text(
          'Password',
          style: TextStyle(
            color: Color(0xFF64748B),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 8),
        ClinicQTextField(
          controller: _passwordController,
          obscureText: state.obscurePassword,
          hintText: '........',
          prefixIcon: Icons.lock_outline_rounded,
          fillColor: Colors.white,
          suffixIconWidget: IconButton(
            icon: Icon(
              state.obscurePassword
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0xFF94A3B8),
            ),
            onPressed: () {
              ref
                  .read(signInViewModelProvider.notifier)
                  .toggleObscurePassword();
            },
          ),
        ),

        // Forgot Password? link
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              context.go(AppRoutes.otpVerification);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Forgot Password functionality is placeholder.',
                  ),
                ),
              );
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Action Button
        ClinicQButton(
          label: 'Continue',
          onPressed: (state.isValid && !state.isLoading) ? _handleSubmit : null,
          isLoading: state.isLoading,
          backgroundColor: const Color(0xFF14B8A6),
          textColor: Colors.white,
          borderRadius: 12,
          height: 50,
        ),
      ],
    );
  }
}
