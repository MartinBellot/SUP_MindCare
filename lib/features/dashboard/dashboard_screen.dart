import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';
import '../../shared/widgets/dashboard_card.dart';
import '../../shared/widgets/mood_chart.dart';
import '../../shared/widgets/quick_actions.dart';
import '../../shared/widgets/mental_weather_card.dart';
import '../../shared/widgets/modern_stats_card.dart';
import '../../shared/widgets/animated_wellness_ring.dart';
import 'package:go_router/go_router.dart';

/// Écran principal - Dashboard ultra moderne de santé mentale
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _cardController;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _cardController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
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
            // App Bar moderne avec animation
            _buildModernAppBar(),
            
            // Contenu principal
            SliverPadding(
              padding: AppSpacing.screenHorizontalPadding,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: AppSpacing.md),
                  
                  // Carte météo mentale (Hero)
                  const MentalWeatherCard(
                    wellnessScore: 78,
                    primaryMood: 'Plutôt optimiste',
                    energyLevel: 4,
                    stressLevel: 2,
                  ),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Section statistiques rapides
                  _buildStatsSection(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Actions rapides améliorées
                  _buildQuickActionsSection(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Graphique d'humeur avec titre
                  _buildChartSection(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Insights et recommandations
                  _buildInsightsSection(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Section progression
                  _buildProgressSection(),
                  
                  const SizedBox(height: 100), // Espace pour la navigation
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: false,
      backgroundColor: AppColors.background,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: AppSpacing.screenHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getGreeting(),
                          style: AppTypography.largeTitle.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.3),
                        
                        const SizedBox(height: 4),
                        
                        Text(
                          'Prenez soin de votre bien-être sur MindCare' ,
                          style: AppTypography.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.3),
                      ],
                    ),
                  ),
                  
                  // Avatar avec indicateur de streak
                  _buildProfileAvatar(),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return GestureDetector(
      onTap: () {
        // Navigation vers le profil utilisateur
        context.go('/profile');
      },
      child:
    Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: AppColors.premiumGradient,
            borderRadius: AppBorderRadius.radiusCircular,
            border: Border.all(
              color: AppColors.borderSecondary,
              width: 2,
            ),
          ),
          child: const Icon(
            Icons.person_rounded,
            color: Colors.white,
            size: AppDimensions.iconLG,
          ),
        ),
        
        // Indicateur de streak
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: AppBorderRadius.radiusCircular,
              border: Border.all(
                color: AppColors.background,
                width: 2,
              ),
            ),
            child: Text(
              '7',
              style: AppTypography.caption2.copyWith(
                color: Colors.white,
                fontWeight: AppTypography.bold,
              ),
            ),
          ),
        ),
      ],
    )).animate().scale(delay: 600.ms);
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vue d\'ensemble',
          style: AppTypography.title2.copyWith(
            color: AppColors.textPrimary,
          ),
        ).animate().fadeIn(delay: 100.ms),
        
        const SizedBox(height: AppSpacing.md),
        
        Row(
          children: [
            Expanded(
              child: ModernStatsCard(
                title: 'Humeur moyenne',
                value: '4.2',
                subtitle: 'Cette semaine',
                icon: Icons.sentiment_satisfied_rounded,
                color: AppColors.moodGood,
                trend: 8.5,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: ModernStatsCard(
                title: 'Méditation',
                value: '127',
                subtitle: 'Min cette semaine',
                icon: Icons.self_improvement_rounded,
                color: AppColors.meditationCalm,
                trend: 12.3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions rapides',
          style: AppTypography.title2.copyWith(
            color: AppColors.textPrimary,
          ),
        ).animate().fadeIn(delay: 100.ms),
        
        const SizedBox(height: AppSpacing.md),
        
        const QuickActions(),
      ],
    );
  }

  Widget _buildChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tendance hebdomadaire',
              style: AppTypography.title2.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigation vers analytics détaillées
              },
              child: Text(
                'Voir plus',
                style: AppTypography.callout.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 100.ms),
        
        const SizedBox(height: AppSpacing.md),
        
        const MoodChart(),
      ],
    );
  }

  Widget _buildInsightsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Insights & Conseils',
          style: AppTypography.title2.copyWith(
            color: AppColors.textPrimary,
          ),
        ).animate().fadeIn(delay: 100.ms),
        
        const SizedBox(height: AppSpacing.md),
        
        DashboardCard(
          title: 'Recommandation personnalisée',
          icon: Icons.psychology_rounded,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.15),
                  borderRadius: AppBorderRadius.radiusSM,
                ),
                child: Text(
                  'STRESS DÉTECTÉ',
                  style: AppTypography.caption1.copyWith(
                    color: AppColors.accent,
                    fontWeight: AppTypography.semibold,
                  ),
                ),
              ),
              
              const SizedBox(height: AppSpacing.md),
              
              Text(
                'Votre niveau de stress a augmenté de 15% cette semaine. Essayez une session de respiration de 5 minutes pour retrouver votre équilibre.',
                style: AppTypography.body.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              
              const SizedBox(height: AppSpacing.md),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Lancer exercice de respiration
                      },
                      icon: const Icon(Icons.air_rounded),
                      label: const Text('Respirer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  TextButton(
                    onPressed: () {
                      // Voir plus d'insights
                    },
                    child: const Text('Plus tard'),
                  ),
                ],
              ),
            ],
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Votre progression',
          style: AppTypography.title2.copyWith(
            color: AppColors.textPrimary,
          ),
        ).animate().fadeIn(delay: 100.ms),
        
        const SizedBox(height: AppSpacing.md),
        
        Row(
          children: [
            // Ring de bien-être
            const AnimatedWellnessRing(
              progress: 0.78,
              color: AppColors.primary,
              label: 'Bien-être\nglobal',
              value: '78%',
            ),
            
            const SizedBox(width: AppSpacing.xl),
            
            // Métriques détaillées
            Expanded(
              child: Column(
                children: [
                  _buildProgressItem('Streak actuel', '7 jours', 0.7, AppColors.accent),
                  const SizedBox(height: AppSpacing.md),
                  _buildProgressItem('Objectif quotidien', '2/3 complété', 0.66, AppColors.primary),
                  const SizedBox(height: AppSpacing.md),
                  _buildProgressItem('Méditations', '12/15 cette semaine', 0.8, AppColors.meditationCalm),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressItem(String title, String subtitle, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.calloutEmphasized.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: AppTypography.caption1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.surfaceDisabled,
          valueColor: AlwaysStoppedAnimation(color),
          borderRadius: AppBorderRadius.radiusSM,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: AppTypography.caption1.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Bonjour';
    if (hour < 18) return 'Bon après-midi';
    return 'Bonsoir';
  }
}