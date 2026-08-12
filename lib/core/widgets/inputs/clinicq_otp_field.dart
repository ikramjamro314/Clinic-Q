import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClinicQOtpField extends StatelessWidget {
  const ClinicQOtpField({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
    this.activeColor = const Color(0xFF2563EB),
    this.inactiveColor,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(int index, String value) onChanged;
  final Color activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final resolvedInactiveColor = inactiveColor ??
        (isDark ? Colors.grey.shade700 : const Color(0xFFE2E8F0));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (index) {
          final controller = controllers[index];
          final focusNode = focusNodes[index];
          
          final isFocused = focusNode.hasFocus;
          final hasText = controller.text.isNotEmpty;
          final isActive = isFocused || hasText;

          return Container(
            width: (MediaQuery.of(context).size.width - 48 - 50) / 6,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isFocused
                    ? activeColor
                    : resolvedInactiveColor,
                width: isFocused ? 2.0 : 1.5,
              ),
              boxShadow: isFocused
                  ? [
                      BoxShadow(
                        color: activeColor.withOpacity(0.08),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                fillColor: Colors.transparent,
                filled: false,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\u200B0-9]')),
              ],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
              onChanged: (value) => onChanged(index, value),
            ),
          );
        },
      ),
    );
  }
}
