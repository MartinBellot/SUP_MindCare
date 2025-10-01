import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';

/// Hero card moderne pour afficher la météo mentale
class MentalWeatherCard extends StatefulWidget {
  final double wellnessScore; // 0-100
  final String primaryMood;
  final int energyLevel; // 1-5
  final int stressLevel; // 1-5

  const MentalWeatherCard({
    super.key,
    required this.wellnessScore,
    required this.primaryMood,
    required this.energyLevel,
    required this.stressLevel,
  });

  @override
  State<MentalWeatherCard> createState() => _MentalWeatherCardState();
}

class _MentalWeatherCardState extends State<MentalWeatherCard> {
  String get weatherEmoji {
    if (widget.wellnessScore >= 80) return '☀️';
    if (widget.wellnessScore >= 60) return '⛅';
    if (widget.wellnessScore >= 40) return '☁️';
    if (widget.wellnessScore >= 20) return '🌧️';
    return '⛈️';
  }

  String get weatherDescription {
    if (widget.wellnessScore >= 80) return 'Ensoleillé';
    if (widget.wellnessScore >= 60) return 'Partiellement nuageux';
    if (widget.wellnessScore >= 40) return 'Nuageux';
    if (widget.wellnessScore >= 20) return 'Pluvieux';
    return 'Orageux';
  }

  Color get gradientStart {
    if (widget.wellnessScore >= 80) return const Color(0xFF4A90E2);
    if (widget.wellnessScore >= 60) return const Color(0xFF7B68EE);
    if (widget.wellnessScore >= 40) return const Color(0xFF9B59B6);
    if (widget.wellnessScore >= 20) return const Color(0xFF34495E);
    return const Color(0xFF2C3E50);
  }

  Color get gradientEnd {
    if (widget.wellnessScore >= 80) return const Color(0xFF87CEEB);
    if (widget.wellnessScore >= 60) return const Color(0xFFDDA0DD);
    if (widget.wellnessScore >= 40) return const Color(0xFFB19CD9);
    if (widget.wellnessScore >= 20) return const Color(0xFF5D6D7E);
    return const Color(0xFF34495E);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [gradientStart, gradientEnd],
        ),
        borderRadius: AppBorderRadius.cardRadius,
        boxShadow: [
          BoxShadow(
            color: gradientStart.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          
          // Contenu principal
          Padding(
            padding: AppSpacing.cardPaddingInsets,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // En-tête
                Row(
                  children: [
                    Container(
                      padding: AppSpacing.paddingSM,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: AppBorderRadius.radiusLG,
                      ),
                      child: const Icon(
                        Icons.psychology_rounded,
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
                            'Météo mentale',
                            style: AppTypography.callout.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Text(
                            '${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}',
                            style: AppTypography.caption1.copyWith(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${widget.wellnessScore.toInt()}%',
                      style: AppTypography.title2.copyWith(
                        color: Colors.white,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Météo principale
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      weatherEmoji,
                      style: const TextStyle(fontSize: 64),
                    ).animate().scale(delay: 300.ms, duration: 600.ms),
                    
                    const SizedBox(width: AppSpacing.lg),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            weatherDescription,
                            style: AppTypography.title3.copyWith(
                              color: Colors.white,
                              fontWeight: AppTypography.semibold,
                            ),
                          ),
                          Text(
                            widget.primaryMood,
                            style: AppTypography.body.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                // Métriques détaillées
                Row(
                  children: [
                    _WeatherMetric(
                      icon: Icons.battery_charging_full_rounded,
                      label: 'Énergie',
                      value: '${widget.energyLevel}/5',
                    ),
                    const SizedBox(width: AppSpacing.xl),
                    _WeatherMetric(
                      icon: Icons.spa_rounded,
                      label: 'Stress',
                      value: _getStressLabel(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3);
  }

  String _getStressLabel() {
    switch (widget.stressLevel) {
      case 1: return 'Très faible';
      case 2: return 'Faible';
      case 3: return 'Modéré';
      case 4: return 'Élevé';
      case 5: return 'Très élevé';
      default: return 'Modéré';
    }
  }
}

class _WeatherMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherMetric({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white.withOpacity(0.9),
          size: AppDimensions.iconMD,
        ),
        const SizedBox(width: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
        ),
      ],
    );
  }
}