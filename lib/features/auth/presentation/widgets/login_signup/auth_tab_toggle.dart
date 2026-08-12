import 'package:flutter/material.dart';

class AuthTabToggle extends StatelessWidget {
  const AuthTabToggle({
    super.key,
    required this.isSignUp,
    required this.onToggle,
  });

  final bool isSignUp;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2F6), // Light blue-grey background pill
        borderRadius: BorderRadius.circular(24),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double pillWidth = constraints.maxWidth / 2;

          return Stack(
            children: [
              // Sliding Active Pill Background
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: isSignUp
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: pillWidth,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),

              // Interactive Text Labels Row
              Row(
                children: [
                  // Sign In Tab
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onToggle(false),
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            color: !isSignUp
                                ? const Color(0xFF2563EB)
                                : const Color(0xFF64748B),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          child: const Text('Sign In'),
                        ),
                      ),
                    ),
                  ),
                  // Sign Up Tab
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onToggle(true),
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            color: isSignUp
                                ? const Color(0xFF2563EB)
                                : const Color(0xFF64748B),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          child: const Text('Sign Up'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
