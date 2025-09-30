import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// Widget de résumé de bien-être
class WellnessSummary extends StatelessWidget {
  const WellnessSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPaddingInsets,
      decoration: BoxDecoration(
        gradient: AppColors.wellnessGradient,
        borderRadius: AppBorderRadius.cardRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: AppSpacing.paddingSM,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: AppBorderRadius.radiusLG,
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: AppDimensions.iconLG,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Score de bien-être',
                      style: AppTypography.callout.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    Text(
                      '78%',
                      style: AppTypography.statisticTitle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: AppBorderRadius.buttonRoundRadius,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      color: Colors.white,
                      size: AppDimensions.iconSM,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+5%',
                      style: AppTypography.caption1.copyWith(
                        color: Colors.white,
                        fontWeight: AppTypography.semibold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Métriques rapides
          Row(
            children: [
              Expanded(
                child: _MetricItem(
                  icon: Icons.sentiment_satisfied_rounded,
                  label: 'Humeur',
                  value: '4/5',
                ),
              ),
              Container(
                width: 1,
                height: 32,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _MetricItem(
                  icon: Icons.battery_charging_full_rounded,
                  label: 'Énergie',
                  value: '3/5',
                ),
              ),
              Container(
                width: 1,
                height: 32,
                color: Colors.white.withOpacity(0.3),
              ),
              Expanded(
                child: _MetricItem(
                  icon: Icons.spa_rounded,
                  label: 'Stress',
                  value: 'Faible',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetricItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.9),
          size: AppDimensions.iconMD,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.calloutEmphasized.copyWith(
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: AppTypography.caption1.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}