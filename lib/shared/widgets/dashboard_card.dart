import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// Carte réutilisable pour le dashboard
class DashboardCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Widget content;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const DashboardCard({
    super.key,
    required this.title,
    this.icon,
    required this.content,
    this.onTap,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? AppColors.backgroundSecondary,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.cardRadius,
        side: const BorderSide(
          color: AppColors.borderSecondary,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorderRadius.cardRadius,
        child: Padding(
          padding: padding ?? AppSpacing.cardPaddingInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête avec titre et icône
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: AppDimensions.iconLG,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      style: AppTypography.title3.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (onTap != null)
                    Icon(
                      Icons.chevron_right_rounded,
                      size: AppDimensions.iconLG,
                      color: AppColors.textTertiary,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              // Contenu
              content,
            ],
          ),
        ),
      ),
    );
  }
}