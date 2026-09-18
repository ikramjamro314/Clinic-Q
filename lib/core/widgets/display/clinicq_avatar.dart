import 'package:flutter/material.dart';
import '../../../app/theme/clinic_q_colors.dart';

class ClinicQAvatar extends StatelessWidget {
  const ClinicQAvatar({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.initials,
    this.radius = 24.0,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String? imageUrl;
  final String? assetPath;
  final String? initials;
  final double radius;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final resolvedBgColor =
        backgroundColor ??
        (isDark
            ? ClinicQColors.darkSurfaceVariant
            : ClinicQColors.primaryTeal.withOpacity(0.1));

    final resolvedFgColor =
        foregroundColor ??
        (isDark ? Colors.white70 : ClinicQColors.primaryTeal);

    Widget? avatarContent;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarContent = ClipOval(
        child: Image.network(
          imageUrl!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildInitialsWidget(resolvedFgColor),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SizedBox(
                width: radius,
                height: radius,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      );
    } else if (assetPath != null && assetPath!.isNotEmpty) {
      avatarContent = ClipOval(
        child: Image.asset(
          assetPath!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _buildInitialsWidget(resolvedFgColor),
        ),
      );
    } else {
      avatarContent = _buildInitialsWidget(resolvedFgColor);
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: resolvedBgColor,
      child: avatarContent,
    );
  }

  Widget _buildInitialsWidget(Color fgColor) {
    return Center(
      child: Text(
        initials ?? '',
        style: TextStyle(
          color: fgColor,
          fontWeight: FontWeight.bold,
          fontSize: radius * 0.8,
        ),
      ),
    );
  }
}
