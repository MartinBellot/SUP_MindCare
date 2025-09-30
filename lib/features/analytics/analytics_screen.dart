import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';

/// Écran d'analytics ultra moderne avec design Apple-like
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen>
    with TickerProviderStateMixin {
  late AnimationController _chartController;
  
  String selectedPeriod = '7 jours';
  final List<String> periods = ['7 jours', '30 jours', '3 mois'];

  @override
  void initState() {
    super.initState();
    _chartController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _chartController.forward();
  }

  @override
  void dispose() {
    _chartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header moderne
            _buildHeader(),
            
            // Contenu
            SliverPadding(
              padding: AppSpacing.screenHorizontalPadding,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: AppSpacing.lg),
                  
                  // Métriques principales
                  _buildMainMetrics(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Graphique d'évolution
                  _buildTrendChart(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Insights IA
                  _buildAIInsights(),
                  
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: true,
      pinned: false,
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back_ios_rounded),
        color: AppColors.primary,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: AppSpacing.screenHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Analytics & Insights',
                style: AppTypography.largeTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.3),
              
              const SizedBox(height: 4),
              
              Text(
                'Découvrez vos patterns de bien-être',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.3),
              
              const SizedBox(height: AppSpacing.lg),
              
              // Sélecteur de période
              _buildPeriodSelector(),
              
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppBorderRadius.radiusLG,
      ),
      child: Row(
        children: periods.map((period) {
          final isSelected = selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedPeriod = period),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: AppBorderRadius.radiusMD,
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: AppTypography.callout.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: isSelected ? AppTypography.semibold : AppTypography.regular,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildMainMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aperçu général',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Score bien-être',
                '82',
                '%',
                Icons.favorite_rounded,
                AppColors.primary,
                '+12%',
                true,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildMetricCard(
                'Humeur moyenne',
                '4.2',
                '/5',
                Icons.sentiment_satisfied_alt_rounded,
                AppColors.accent,
                '+0.3',
                true,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Méditation totale',
                '3h 45m',
                '',
                Icons.self_improvement_rounded,
                AppColors.meditationSleep,
                '+45m',
                true,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildMetricCard(
                'Jours consécutifs',
                '12',
                'jours',
                Icons.local_fire_department_rounded,
                AppColors.warning,
                '+2',
                true,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 500.ms);
  }

  Widget _buildMetricCard(String title, String value, String unit, IconData icon, Color color, String trend, bool isPositive) {
    return Container(
      padding: AppSpacing.cardPaddingInsets,
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppBorderRadius.cardRadius,
        border: Border.all(
          color: AppColors.borderSecondary,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: AppSpacing.paddingSM,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: AppBorderRadius.radiusMD,
                ),
                child: Icon(icon, color: color, size: AppDimensions.iconMD),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive ? AppColors.accent.withOpacity(0.15) : AppColors.warning.withOpacity(0.15),
                  borderRadius: AppBorderRadius.radiusSM,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                      color: isPositive ? AppColors.accent : AppColors.warning,
                      size: 12,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      trend,
                      style: AppTypography.caption2.copyWith(
                        color: isPositive ? AppColors.accent : AppColors.warning,
                        fontWeight: AppTypography.semibold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTypography.title2.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: AppTypography.bold,
                ),
              ),
              if (unit.isNotEmpty) ...[
                const SizedBox(width: 2),
                Text(
                  unit,
                  style: AppTypography.caption1.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: AppTypography.caption1.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChart() {
    return Container(
      height: 280,
      padding: AppSpacing.cardPaddingInsets,
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppBorderRadius.cardRadius,
        border: Border.all(
          color: AppColors.borderSecondary,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Évolution du bien-être',
                style: AppTypography.title3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: AppColors.premiumGradient,
                  borderRadius: AppBorderRadius.radiusSM,
                ),
                child: Text(
                  'IA Powered',
                  style: AppTypography.caption1.copyWith(
                    color: Colors.white,
                    fontWeight: AppTypography.semibold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: AnimatedBuilder(
              animation: _chartController,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(double.infinity, double.infinity),
                  painter: WellnessChartPainter(
                    animationProgress: _chartController.value,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms);
  }

  Widget _buildAIInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Insights IA',
              style: AppTypography.title3.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                gradient: AppColors.premiumGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        
        _buildInsightCard(
          '🎯 Pattern détecté',
          'Excellente progression !',
          'Vous méditez régulièrement le matin, ce qui améliore votre humeur de 23% en moyenne.',
          AppColors.accent,
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        _buildInsightCard(
          '💡 Recommandation',
          'Optimisez vos weekends',
          'Vos scores baissent le dimanche. Essayez une méditation de 10min avant 11h.',
          AppColors.primary,
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        _buildInsightCard(
          '🏆 Objectif personnalisé',
          'Défi 21 jours',
          'Vous êtes à 3 jours d\'un nouveau record ! Continuez pour débloquer des insights avancés.',
          AppColors.warning,
        ),
      ],
    ).animate().fadeIn(delay: 900.ms);
  }

  Widget _buildInsightCard(String emoji, String title, String description, Color accentColor) {
    return Container(
      padding: AppSpacing.cardPaddingInsets,
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.08),
        borderRadius: AppBorderRadius.cardRadius,
        border: Border.all(
          color: accentColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: AppSpacing.paddingMD,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.15),
              borderRadius: AppBorderRadius.radiusMD,
            ),
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.calloutEmphasized.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTypography.caption1.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: accentColor.withOpacity(0.7),
            size: AppDimensions.iconSM,
          ),
        ],
      ),
    );
  }
}

class WellnessChartPainter extends CustomPainter {
  final double animationProgress;

  WellnessChartPainter({required this.animationProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Données simulées pour la courbe de bien-être
    final dataPoints = [3.2, 3.8, 4.1, 3.5, 4.3, 4.7, 4.2, 4.8, 4.1, 4.6, 4.9, 4.3];
    final spacing = size.width / (dataPoints.length - 1);

    // Gradient pour la ligne
    final gradient = LinearGradient(
      colors: [AppColors.primary, AppColors.accent],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    paint.shader = gradient.createShader(rect);

    // Dessiner la courbe principale
    final path = Path();
    for (int i = 0; i < dataPoints.length; i++) {
      final x = i * spacing;
      final y = size.height - (dataPoints[i] / 5.0) * size.height;
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Animer le tracé
    final pathMetrics = path.computeMetrics();
    if (pathMetrics.isNotEmpty) {
      final pathMetric = pathMetrics.first;
      final extractedPath = pathMetric.extractPath(0, pathMetric.length * animationProgress);
      canvas.drawPath(extractedPath, paint);
    }

    // Dessiner l'aire sous la courbe
    final areaPath = Path.from(path);
    areaPath.lineTo(size.width, size.height);
    areaPath.lineTo(0, size.height);
    areaPath.close();

    final areaPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          AppColors.primary.withOpacity(0.3),
          AppColors.primary.withOpacity(0.05),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);

    canvas.drawPath(areaPath, areaPaint);

    // Dessiner les points
    final pointPaint = Paint()..style = PaintingStyle.fill;
    
    for (int i = 0; i < dataPoints.length; i++) {
      final progress = (i + 1) / dataPoints.length;
      if (animationProgress >= progress) {
        final x = i * spacing;
        final y = size.height - (dataPoints[i] / 5.0) * size.height;
        
        pointPaint.color = Colors.white;
        canvas.drawCircle(Offset(x, y), 6, pointPaint);
        
        pointPaint.color = AppColors.primary;
        canvas.drawCircle(Offset(x, y), 4, pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}