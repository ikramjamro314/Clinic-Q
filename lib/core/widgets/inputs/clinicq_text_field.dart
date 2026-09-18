import 'package:flutter/material.dart';
import '../../../app/theme/clinic_q_colors.dart';

class ClinicQTextField extends StatefulWidget {
  const ClinicQTextField({
    super.key,
    this.label,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.prefixIconWidget,
    this.suffixIcon,
    this.suffixIconWidget,
    this.onSuffixIconPressed,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled,
    this.onTap,
    this.isPill = false,
    this.fillColor,
    this.textStyle,
    this.hintStyle,
    this.borderRadius = 12,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
  });

  final String? label;
  final String hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final Widget? prefixIconWidget;
  final IconData? suffixIcon;
  final Widget? suffixIconWidget;
  final VoidCallback? onSuffixIconPressed;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool? enabled;
  final VoidCallback? onTap;
  final bool isPill;
  final Color? fillColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double borderRadius;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;

  @override
  State<ClinicQTextField> createState() => _ClinicQTextFieldState();
}

class _ClinicQTextFieldState extends State<ClinicQTextField> {
  FocusNode? _localFocusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_localFocusNode ??= FocusNode());
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant ClinicQTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChange);
      _localFocusNode?.removeListener(_handleFocusChange);

      if (widget.focusNode != null && _localFocusNode != null) {
        _localFocusNode!.dispose();
        _localFocusNode = null;
      }

      _effectiveFocusNode.addListener(_handleFocusChange);
      _isFocused = _effectiveFocusNode.hasFocus;
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChange);
    _localFocusNode?.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _effectiveFocusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final double computedRadius = widget.isPill ? 28.0 : widget.borderRadius;
    final BorderSide computedBorderSide = widget.isPill
        ? BorderSide.none
        : BorderSide(
            color: isDark
                ? ClinicQColors.darkSurfaceVariant
                : ClinicQColors.inputBorderDefault,
            width: 1.5,
          );

    final BorderSide focusedBorderSide = widget.isPill
        ? BorderSide.none
        : const BorderSide(color: ClinicQColors.inputBorderFocused, width: 2.0);

    // Dynamic coloring of prefix and suffix icons based on focus
    Widget? buildPrefixIcon() {
      if (widget.prefixIconWidget != null) {
        return widget.prefixIconWidget;
      }
      if (widget.prefixIcon != null) {
        return Icon(
          widget.prefixIcon,
          size: 20,
          color: _isFocused
              ? (isDark ? ClinicQColors.lightTeal : ClinicQColors.primaryTeal)
              : (isDark
                    ? ClinicQColors.textTertiary
                    : ClinicQColors.textSecondary),
        );
      }
      return null;
    }

    Widget? buildSuffixIcon() {
      if (widget.suffixIconWidget != null) {
        return widget.suffixIconWidget;
      }
      if (widget.suffixIcon != null) {
        return IconButton(
          icon: Icon(
            widget.suffixIcon,
            size: 20,
            color: _isFocused
                ? (isDark ? ClinicQColors.lightTeal : ClinicQColors.primaryTeal)
                : (isDark
                      ? ClinicQColors.textTertiary
                      : ClinicQColors.textSecondary),
          ),
          onPressed: widget.onSuffixIconPressed,
        );
      }
      return null;
    }

    final field = TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      focusNode: _effectiveFocusNode,
      style:
          widget.textStyle ??
          theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? Colors.white : ClinicQColors.textPrimary,
          ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle:
            widget.hintStyle ??
            theme.textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? ClinicQColors.textTertiary
                  : ClinicQColors.inputPlaceholder,
            ),
        prefixIcon: buildPrefixIcon(),
        suffixIcon: buildSuffixIcon(),
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.isPill ? 24 : 16,
          vertical: widget.isPill ? 18 : 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(computedRadius),
          borderSide: computedBorderSide,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(computedRadius),
          borderSide: computedBorderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(computedRadius),
          borderSide: focusedBorderSide,
        ),
        filled: true,
        fillColor:
            widget.fillColor ??
            (widget.isPill
                ? (isDark ? ClinicQColors.darkSurface : Colors.white)
                : (isDark
                      ? ClinicQColors.darkSurface
                      : ClinicQColors.inputBackground)),
      ),
    );

    if (widget.label != null && widget.label!.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label!,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : ClinicQColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          field,
        ],
      );
    }

    return field;
  }
}
