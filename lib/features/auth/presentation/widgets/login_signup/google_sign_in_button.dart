import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dark blue square containing a white 'G'
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B), // Dark blue background
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: const Text(
                'G',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  fontFamily: 'sans-serif',
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Sign in with Google',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
