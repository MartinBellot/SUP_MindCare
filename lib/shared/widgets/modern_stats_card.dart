import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';

/// Carte de statistique moderne avec animation
class ModernStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double? trend; // +/- pourcentage
  final VoidCallback? onTap;

  const ModernStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.trend,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.backgroundSecondary,
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
          padding: AppSpacing.cardPaddingInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête avec icône
              Row(
                children: [
                  Container(
                    padding: AppSpacing.paddingSM,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: AppBorderRadius.radiusSM,
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: AppDimensions.iconLG,
                    ),
                  ),
                  const Spacer(),
                  if (trend != null)
                    _TrendIndicator(trend: trend!),
                ],
              ),
              
              const SizedBox(height: AppSpacing.lg),
              
              // Valeur principale
              Text(
                value,
                style: AppTypography.statisticTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),
              
              const SizedBox(height: AppSpacing.xs),
              
              // Titre
              Text(
                title,
                style: AppTypography.calloutEmphasized.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              
              // Sous-titre
              Text(
                subtitle,
                style: AppTypography.caption1.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2);
  }
}

/// Indicateur de tendance avec flèche
class _TrendIndicator extends StatelessWidget {
  final double trend;

  const _TrendIndicator({required this.trend});

  @override
  Widget build(BuildContext context) {
    final isPositive = trend >= 0;
    final color = isPositive ? AppColors.accent : AppColors.destructive;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: AppBorderRadius.radiusSM,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
            color: color,
            size: AppDimensions.iconSM,
          ),
          const SizedBox(width: 4),
          Text(
            '${isPositive ? '+' : ''}${trend.toStringAsFixed(1)}%',
            style: AppTypography.caption1.copyWith(
              color: color,
              fontWeight: AppTypography.semibold,
            ),
          ),
        ],
      ),
    );
  }
}