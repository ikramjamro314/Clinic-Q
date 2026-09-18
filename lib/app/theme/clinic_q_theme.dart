import 'package:flutter/material.dart';

import 'clinic_q_colors.dart';

@immutable
class ClinicQGradients extends ThemeExtension<ClinicQGradients> {
  final LinearGradient primary;
  final LinearGradient primaryPressed;
  final LinearGradient secondary;
  final LinearGradient background;
  final LinearGradient accent;
  final LinearGradient darkOverlay;
  final LinearGradient queueProgress;
  final LinearGradient navIndicator;
  final LinearGradient appointmentHeader;
  final LinearGradient shimmer;

  const ClinicQGradients({
    required this.primary,
    required this.primaryPressed,
    required this.secondary,
    required this.background,
    required this.accent,
    required this.darkOverlay,
    required this.queueProgress,
    required this.navIndicator,
    required this.appointmentHeader,
    required this.shimmer,
  });

  static const ClinicQGradients light = ClinicQGradients(
    primary: ClinicQColors.gradientPrimary,
    primaryPressed: ClinicQColors.gradientPrimaryPressed,
    secondary: ClinicQColors.gradientSecondary,
    background: ClinicQColors.gradientBackground,
    accent: ClinicQColors.gradientAccent,
    darkOverlay: ClinicQColors.gradientDarkOverlay,
    queueProgress: ClinicQColors.gradientQueueProgress,
    navIndicator: ClinicQColors.gradientNavIndicator,
    appointmentHeader: ClinicQColors.gradientAppointmentHeader,
    shimmer: ClinicQColors.gradientShimmer,
  );

  static const ClinicQGradients dark = light;

  @override
  ClinicQGradients copyWith({
    LinearGradient? primary,
    LinearGradient? primaryPressed,
    LinearGradient? secondary,
    LinearGradient? background,
    LinearGradient? accent,
    LinearGradient? darkOverlay,
    LinearGradient? queueProgress,
    LinearGradient? navIndicator,
    LinearGradient? appointmentHeader,
    LinearGradient? shimmer,
  }) {
    return ClinicQGradients(
      primary: primary ?? this.primary,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      accent: accent ?? this.accent,
      darkOverlay: darkOverlay ?? this.darkOverlay,
      queueProgress: queueProgress ?? this.queueProgress,
      navIndicator: navIndicator ?? this.navIndicator,
      appointmentHeader: appointmentHeader ?? this.appointmentHeader,
      shimmer: shimmer ?? this.shimmer,
    );
  }

  @override
  ClinicQGradients lerp(ThemeExtension<ClinicQGradients>? other, double t) {
    if (other is! ClinicQGradients) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}

extension ClinicQThemeContext on BuildContext {
  ClinicQGradients get clinicQGradients =>
      Theme.of(this).extension<ClinicQGradients>()!;
}

class ClinicQTheme {
  ClinicQTheme._();

  static ThemeData light() {
    return _buildTheme(
      colorScheme: const ColorScheme.light(
        primary: ClinicQColors.primaryTeal,
        onPrimary: ClinicQColors.textWhite,
        primaryContainer: ClinicQColors.lightTeal,
        onPrimaryContainer: ClinicQColors.textPrimary,
        secondary: ClinicQColors.primaryBlue,
        onSecondary: ClinicQColors.textWhite,
        secondaryContainer: Color(0xFFBAE6FD),
        onSecondaryContainer: ClinicQColors.textPrimary,
        tertiary: ClinicQColors.darkTeal,
        onTertiary: ClinicQColors.textWhite,
        tertiaryContainer: Color(0xFF99F6E4),
        onTertiaryContainer: ClinicQColors.textPrimary,
        error: ClinicQColors.errorIcon,
        onError: ClinicQColors.textWhite,
        errorContainer: ClinicQColors.errorBackground,
        onErrorContainer: ClinicQColors.errorText,
        surface: ClinicQColors.cardBackground,
        onSurface: ClinicQColors.textPrimary,
        surfaceContainerHighest: ClinicQColors.secondaryBackground,
        onSurfaceVariant: ClinicQColors.textSecondary,
        outline: ClinicQColors.dividerMedium,
        outlineVariant: ClinicQColors.dividerLight,
        shadow: Colors.black,
        scrim: ClinicQColors.overlayBackground,
        inverseSurface: ClinicQColors.darkBackground,
        onInverseSurface: ClinicQColors.textWhite,
        inversePrimary: ClinicQColors.lightTeal,
      ),
      gradients: ClinicQGradients.light,
      brightness: Brightness.light,
    );
  }

  static ThemeData dark() {
    return _buildTheme(
      colorScheme: const ColorScheme.dark(
        primary: ClinicQColors.lightTeal,
        onPrimary: ClinicQColors.textPrimary,
        primaryContainer: ClinicQColors.darkTeal,
        onPrimaryContainer: ClinicQColors.textWhite,
        secondary: ClinicQColors.primaryBlue,
        onSecondary: ClinicQColors.textWhite,
        secondaryContainer: Color(0xFF0369A1),
        onSecondaryContainer: ClinicQColors.textWhite,
        tertiary: ClinicQColors.lightTeal,
        onTertiary: ClinicQColors.textPrimary,
        tertiaryContainer: ClinicQColors.darkTeal,
        onTertiaryContainer: ClinicQColors.textWhite,
        error: ClinicQColors.errorIcon,
        onError: ClinicQColors.textWhite,
        errorContainer: Color(0xFF7F1D1D),
        onErrorContainer: Color(0xFFFECACA),
        surface: ClinicQColors.darkSurface,
        onSurface: ClinicQColors.textWhite,
        surfaceContainerHighest: ClinicQColors.darkSurfaceVariant,
        onSurfaceVariant: ClinicQColors.textTertiary,
        outline: ClinicQColors.dividerStrong,
        outlineVariant: ClinicQColors.dividerMedium,
        shadow: Colors.black,
        scrim: ClinicQColors.overlayBackground,
        inverseSurface: ClinicQColors.appBackground,
        onInverseSurface: ClinicQColors.textPrimary,
        inversePrimary: ClinicQColors.primaryTeal,
      ),
      gradients: ClinicQGradients.dark,
      brightness: Brightness.dark,
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required ClinicQGradients gradients,
    required Brightness brightness,
  }) {
    final isDark = brightness == Brightness.dark;
    final baseTextTheme =
        (isDark
                ? Typography.material2021().white
                : Typography.material2021().black)
            .apply(
              bodyColor: colorScheme.onSurface,
              displayColor: colorScheme.onSurface,
            );

    final scaffoldBackground = isDark
        ? ClinicQColors.darkBackground
        : ClinicQColors.appBackground;
    final cardSurface = isDark
        ? ClinicQColors.darkSurface
        : ClinicQColors.cardBackground;
    final borderColor = isDark
        ? ClinicQColors.dividerStrong
        : ClinicQColors.dividerMedium;
    final subduedSurface = isDark
        ? ClinicQColors.darkSurfaceVariant
        : ClinicQColors.secondaryBackground;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      canvasColor: scaffoldBackground,
      extensions: <ThemeExtension<dynamic>>[gradients],
      textTheme: baseTextTheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: scaffoldBackground,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: baseTextTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      cardTheme: CardThemeData(
        color: cardSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: borderColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 1.2),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          textStyle: baseTextTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: subduedSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        hintStyle: baseTextTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        labelStyle: baseTextTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        prefixIconColor: colorScheme.onSurfaceVariant,
        suffixIconColor: colorScheme.onSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.error, width: 1.4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.error, width: 1.6),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: subduedSurface,
        disabledColor: borderColor,
        selectedColor: colorScheme.primaryContainer,
        secondarySelectedColor: colorScheme.primaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        labelStyle: baseTextTheme.labelMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
        secondaryLabelStyle: baseTextTheme.labelMedium?.copyWith(
          color: colorScheme.onPrimaryContainer,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        side: BorderSide(color: borderColor),
      ),
      dividerTheme: DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 1,
      ),
      iconTheme: IconThemeData(color: colorScheme.primary),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cardSurface,
        elevation: 0,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return baseTextTheme.labelMedium?.copyWith(
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          );
        }),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cardSurface,
        contentTextStyle: baseTextTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
        actionTextColor: colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: borderColor),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        circularTrackColor: borderColor,
        linearTrackColor: borderColor,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primaryContainer;
          }
          return borderColor;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStatePropertyAll(colorScheme.onPrimary),
        side: BorderSide(color: colorScheme.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return colorScheme.outline;
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: borderColor,
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withValues(alpha: 0.12),
      ),
    );
  }
}
