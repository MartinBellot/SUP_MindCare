import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';

/// Écran ultra moderne d'historique d'humeur avec design Apple-like
class MoodHistoryScreen extends StatefulWidget {
  const MoodHistoryScreen({super.key});

  @override
  State<MoodHistoryScreen> createState() => _MoodHistoryScreenState();
}

class _MoodHistoryScreenState extends State<MoodHistoryScreen>
    with TickerProviderStateMixin {
  String selectedPeriod = 'Semaine';
  late AnimationController _chartController;
  late AnimationController _cardController;

  final List<String> periods = ['Semaine', 'Mois', 'Année'];
  
  // Données factices pour la démonstration
  final List<MoodEntry> weeklyData = [
    MoodEntry(day: 'Lun', mood: 4, energy: 3, stress: 2, date: DateTime.now().subtract(const Duration(days: 6))),
    MoodEntry(day: 'Mar', mood: 3, energy: 4, stress: 3, date: DateTime.now().subtract(const Duration(days: 5))),
    MoodEntry(day: 'Mer', mood: 5, energy: 5, stress: 1, date: DateTime.now().subtract(const Duration(days: 4))),
    MoodEntry(day: 'Jeu', mood: 2, energy: 2, stress: 4, date: DateTime.now().subtract(const Duration(days: 3))),
    MoodEntry(day: 'Ven', mood: 4, energy: 4, stress: 2, date: DateTime.now().subtract(const Duration(days: 2))),
    MoodEntry(day: 'Sam', mood: 5, energy: 4, stress: 1, date: DateTime.now().subtract(const Duration(days: 1))),
    MoodEntry(day: 'Dim', mood: 4, energy: 3, stress: 2, date: DateTime.now()),
  ];

  @override
  void initState() {
    super.initState();
    _chartController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    Future.delayed(const Duration(milliseconds: 300), () {
      _chartController.forward();
    });
    _cardController.forward();
  }

  @override
  void dispose() {
    _chartController.dispose();
    _cardController.dispose();
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
            // App Bar moderne
            _buildAppBar(),
            
            // Contenu principal
            SliverPadding(
              padding: AppSpacing.screenHorizontalPadding,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: AppSpacing.lg),
                  
                  // Sélecteur de période
                  _buildPeriodSelector(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Résumé des statistiques
                  _buildStatsOverview(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Graphique principal
                  _buildMainChart(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Insights et tendances
                  _buildInsights(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Liste détaillée des entrées
                  _buildDetailedHistory(),
                  
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 100,
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
                'Historique d\'humeur',
                style: AppTypography.largeTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.3),
              
              const SizedBox(height: 4),
              
              Text(
                'Suivez votre évolution au fil du temps',
                style: AppTypography.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.3),
              
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
        border: Border.all(
          color: AppColors.borderSecondary,
          width: 0.5,
        ),
      ),
      child: Row(
        children: periods.map((period) {
          final isSelected = selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedPeriod = period;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected 
                    ? AppColors.primary 
                    : Colors.transparent,
                  borderRadius: AppBorderRadius.radiusMD,
                  boxShadow: isSelected 
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
                ),
                child: Text(
                  period,
                  textAlign: TextAlign.center,
                  style: AppTypography.callout.copyWith(
                    color: isSelected 
                      ? Colors.white 
                      : AppColors.textSecondary,
                    fontWeight: isSelected 
                      ? AppTypography.semibold 
                      : AppTypography.regular,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildStatsOverview() {
    final avgMood = weeklyData.map((e) => e.mood).reduce((a, b) => a + b) / weeklyData.length;
    final avgEnergy = weeklyData.map((e) => e.energy).reduce((a, b) => a + b) / weeklyData.length;
    final avgStress = weeklyData.map((e) => e.stress).reduce((a, b) => a + b) / weeklyData.length;
    
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Humeur moyenne',
            avgMood.toStringAsFixed(1),
            Icons.sentiment_satisfied_alt_rounded,
            _getMoodColor(avgMood.round()),
            '/5',
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _buildStatCard(
            'Énergie moyenne',
            avgEnergy.toStringAsFixed(1),
            Icons.battery_charging_full_rounded,
            AppColors.accent,
            '/5',
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _buildStatCard(
            'Stress moyen',
            avgStress.toStringAsFixed(1),
            Icons.spa_rounded,
            AppColors.warning,
            '/5',
          ),
        ),
      ],
    ).animate().fadeIn(delay: 500.ms);
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String suffix) {
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
          Icon(icon, color: color, size: AppDimensions.iconLG),
          const SizedBox(height: AppSpacing.sm),
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
              Text(
                suffix,
                style: AppTypography.caption1.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
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

  Widget _buildMainChart() {
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
                'Évolution hebdomadaire',
                style: AppTypography.title3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              _buildLegend(),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: _buildCustomChart(),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms);
  }

  Widget _buildLegend() {
    return Row(
      children: [
        _buildLegendItem('Humeur', AppColors.primary),
        const SizedBox(width: AppSpacing.md),
        _buildLegendItem('Énergie', AppColors.accent),
        const SizedBox(width: AppSpacing.md),
        _buildLegendItem('Stress', AppColors.warning),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTypography.caption1.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildCustomChart() {
    return AnimatedBuilder(
      animation: _chartController,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(double.infinity, 200),
          painter: MoodChartPainter(
            data: weeklyData,
            animationProgress: _chartController.value,
          ),
        );
      },
    );
  }

  Widget _buildInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Insights & Tendances',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        _buildInsightCard(
          '📈 Amélioration',
          'Votre humeur s\'est améliorée de 25% cette semaine',
          AppColors.accent,
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        _buildInsightCard(
          '🧘 Gestion du stress',
          'Vos niveaux de stress sont plus bas les weekends',
          AppColors.meditationSleep,
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        _buildInsightCard(
          '⚡ Énergie optimale',
          'Votre énergie est à son pic en milieu de semaine',
          AppColors.warning,
        ),
      ],
    ).animate().fadeIn(delay: 900.ms);
  }

  Widget _buildInsightCard(String title, String description, Color color) {
    return Container(
      padding: AppSpacing.cardPaddingInsets,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppBorderRadius.cardRadius,
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: AppSpacing.paddingSM,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: AppBorderRadius.radiusMD,
            ),
            child: Icon(
              Icons.lightbulb_outline_rounded,
              color: color,
              size: AppDimensions.iconMD,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.callout.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.semibold,
                  ),
                ),
                Text(
                  description,
                  style: AppTypography.caption1.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Historique détaillé',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        ...weeklyData.reversed.map((entry) => _buildHistoryItem(entry)),
      ],
    ).animate().fadeIn(delay: 1100.ms);
  }

  Widget _buildHistoryItem(MoodEntry entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: AppSpacing.cardPaddingInsets,
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppBorderRadius.cardRadius,
        border: Border.all(
          color: AppColors.borderSecondary,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          // Date et jour
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.day,
                style: AppTypography.callout.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: AppTypography.semibold,
                ),
              ),
              Text(
                '${entry.date.day.toString().padLeft(2, '0')}/${entry.date.month.toString().padLeft(2, '0')}',
                style: AppTypography.caption1.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          
          const SizedBox(width: AppSpacing.lg),
          
          // Métriques
          Expanded(
            child: Row(
              children: [
                _buildMetricIndicator('😊', entry.mood, _getMoodColor(entry.mood)),
                const SizedBox(width: AppSpacing.lg),
                _buildMetricIndicator('⚡', entry.energy, AppColors.accent),
                const SizedBox(width: AppSpacing.lg),
                _buildMetricIndicator('😰', entry.stress, AppColors.warning),
              ],
            ),
          ),
          
          // Flèche
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.textTertiary,
            size: AppDimensions.iconSM,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricIndicator(String emoji, int value, Color color) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: AppBorderRadius.radiusSM,
          ),
          child: Text(
            value.toString(),
            style: AppTypography.caption1.copyWith(
              color: color,
              fontWeight: AppTypography.semibold,
            ),
          ),
        ),
      ],
    );
  }

  Color _getMoodColor(int mood) {
    switch (mood) {
      case 1:
        return AppColors.moodTerrible;
      case 2:
        return AppColors.moodPoor;
      case 3:
        return AppColors.moodNeutral;
      case 4:
        return AppColors.moodGood;
      case 5:
        return AppColors.moodExcellent;
      default:
        return AppColors.moodNeutral;
    }
  }
}

class MoodEntry {
  final String day;
  final int mood;
  final int energy;
  final int stress;
  final DateTime date;

  MoodEntry({
    required this.day,
    required this.mood,
    required this.energy,
    required this.stress,
    required this.date,
  });
}

class MoodChartPainter extends CustomPainter {
  final List<MoodEntry> data;
  final double animationProgress;

  MoodChartPainter({
    required this.data,
    required this.animationProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final moodPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final energyPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final stressPaint = Paint()
      ..color = AppColors.warning
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final pointPaint = Paint()
      ..style = PaintingStyle.fill;

    final spacing = size.width / (data.length - 1);
    final maxValue = 5.0;

    // Dessiner les lignes
    _drawLine(canvas, size, data.map((e) => e.mood).toList(), moodPaint, spacing, maxValue);
    _drawLine(canvas, size, data.map((e) => e.energy).toList(), energyPaint, spacing, maxValue);
    _drawLine(canvas, size, data.map((e) => e.stress).toList(), stressPaint, spacing, maxValue);

    // Dessiner les points
    for (int i = 0; i < data.length; i++) {
      final x = i * spacing;
      final progress = (i + 1) / data.length;
      
      if (animationProgress >= progress) {
        // Point d'humeur
        pointPaint.color = AppColors.primary;
        final moodY = size.height - (data[i].mood / maxValue) * size.height;
        canvas.drawCircle(Offset(x, moodY), 4, pointPaint);

        // Point d'énergie
        pointPaint.color = AppColors.accent;
        final energyY = size.height - (data[i].energy / maxValue) * size.height;
        canvas.drawCircle(Offset(x, energyY), 4, pointPaint);

        // Point de stress
        pointPaint.color = AppColors.warning;
        final stressY = size.height - (data[i].stress / maxValue) * size.height;
        canvas.drawCircle(Offset(x, stressY), 4, pointPaint);
      }
    }

    // Dessiner les labels des jours
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < data.length; i++) {
      final x = i * spacing;
      textPainter.text = TextSpan(
        text: data[i].day,
        style: AppTypography.caption1.copyWith(
          color: AppColors.textSecondary,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height + 10),
      );
    }
  }

  void _drawLine(Canvas canvas, Size size, List<int> values, Paint paint, double spacing, double maxValue) {
    final path = Path();
    
    for (int i = 0; i < values.length; i++) {
      final x = i * spacing;
      final y = size.height - (values[i] / maxValue) * size.height;
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Animer le tracé de la ligne
    final pathMetrics = path.computeMetrics();
    final pathMetric = pathMetrics.first;
    final extractedPath = pathMetric.extractPath(0, pathMetric.length * animationProgress);
    
    canvas.drawPath(extractedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}