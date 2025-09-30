import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';

/// Écran de profil ultra moderne avec design Apple-like
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _avatarController;
  late AnimationController _cardController;

  @override
  void initState() {
    super.initState();
    _avatarController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _avatarController.forward();
    _cardController.forward();
  }

  @override
  void dispose() {
    _avatarController.dispose();
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
            // Header avec profil
            _buildProfileHeader(),
            
            // Contenu
            SliverPadding(
              padding: AppSpacing.screenHorizontalPadding,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: AppSpacing.lg),
                  
                  // Statistiques personnelles
                  _buildPersonalStats(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Objectifs et badges
                  _buildAchievements(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Paramètres
                  _buildSettings(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Actions
                  _buildActions(),
                  
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return SliverAppBar(
      expandedHeight: 308,
      floating: true,
      pinned: false,
      backgroundColor: AppColors.background,
      elevation: 0, 
      actions: [
        IconButton(
          onPressed: () {
            // Éditer le profil
          },
          icon: const Icon(Icons.edit_rounded),
          color: AppColors.primary,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.1),
                AppColors.background,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: AppSpacing.screenHorizontalPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60), // Pour l'app bar
                
                // Avatar avec animation
                AnimatedBuilder(
                  animation: _avatarController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.8 + (_avatarController.value * 0.2),
                      child: Stack(
                        children: [
                          // Cercle de progression
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: 0.73, // 73% de progression
                              strokeWidth: 6,
                              backgroundColor: AppColors.borderSecondary,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                            ),
                          ),
                          
                          // Avatar
                          Positioned.fill(
                            child: Container(
                              margin: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.premiumGradient,
                              ),
                              child: const Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 48,
                              ),
                            ),
                          ),
                          
                          // Badge de niveau
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppColors.premiumGradient,
                                borderRadius: AppBorderRadius.radiusSM,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Lvl 12',
                                style: AppTypography.caption1.copyWith(
                                  color: Colors.white,
                                  fontWeight: AppTypography.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Nom et informations
                Text(
                  'Alex Martin',
                  style: AppTypography.title1.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.bold,
                  ),
                ).animate().fadeIn(delay: 400.ms),
                
                const SizedBox(height: 4),
                
                Text(
                  'Membre depuis 3 mois',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ).animate().fadeIn(delay: 600.ms),
                
                const SizedBox(height: AppSpacing.md),
                
                // Status
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.15),
                    borderRadius: AppBorderRadius.radiusLG,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_fire_department_rounded,
                        color: AppColors.accent,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Série de 12 jours',
                        style: AppTypography.callout.copyWith(
                          color: AppColors.accent,
                          fontWeight: AppTypography.semibold,
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 800.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vos statistiques',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Sessions totales',
                '47',
                Icons.self_improvement_rounded,
                AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                'Temps médité',
                '8h 32m',
                Icons.access_time_rounded,
                AppColors.accent,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Humeur moyenne',
                '4.3/5',
                Icons.sentiment_satisfied_alt_rounded,
                AppColors.warning,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                'Objectifs atteints',
                '23/30',
                Icons.flag_rounded,
                AppColors.meditationSleep,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(delay: 500.ms);
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
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
        children: [
          Icon(icon, color: color, size: AppDimensions.iconLG),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.title3.copyWith(
              color: AppColors.textPrimary,
              fontWeight: AppTypography.bold,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.caption1.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Badges & Réussites',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildBadge('🏆', 'Premier pas', 'Première méditation', true),
              _buildBadge('🔥', 'Série de 7', '7 jours consécutifs', true),
              _buildBadge('🧘', 'Zen Master', '50 sessions complètes', true),
              _buildBadge('⭐', 'Perfectionniste', '30 jours parfaits', false),
              _buildBadge('🎯', 'Objectif 100', '100 sessions totales', false),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 700.ms);
  }

  Widget _buildBadge(String emoji, String title, String description, bool unlocked) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      padding: AppSpacing.cardPaddingInsets,
      decoration: BoxDecoration(
        color: unlocked 
          ? AppColors.primary.withOpacity(0.1)
          : AppColors.backgroundSecondary,
        borderRadius: AppBorderRadius.cardRadius,
        border: Border.all(
          color: unlocked 
            ? AppColors.primary.withOpacity(0.3)
            : AppColors.borderSecondary,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: TextStyle(
              fontSize: 32,
              color: unlocked ? null : Colors.grey,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            style: AppTypography.callout.copyWith(
              color: unlocked ? AppColors.textPrimary : AppColors.textTertiary,
              fontWeight: AppTypography.semibold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTypography.caption2.copyWith(
              color: unlocked ? AppColors.textSecondary : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Paramètres',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        _buildSettingItem(
          Icons.notifications_rounded,
          'Notifications',
          'Gérer vos rappels',
          () {},
        ),
        _buildSettingItem(
          Icons.dark_mode_rounded,
          'Thème',
          'Sombre (recommandé)',
          () {},
        ),
        _buildSettingItem(
          Icons.language_rounded,
          'Langue',
          'Français',
          () {},
        ),
        _buildSettingItem(
          Icons.backup_rounded,
          'Sauvegarde',
          'Synchroniser les données',
          () {},
        ),
      ],
    ).animate().fadeIn(delay: 900.ms);
  }

  Widget _buildSettingItem(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: AppBorderRadius.cardRadius,
        border: Border.all(
          color: AppColors.borderSecondary,
          width: 0.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppBorderRadius.cardRadius,
          child: Padding(
            padding: AppSpacing.cardPaddingInsets,
            child: Row(
              children: [
                Icon(icon, color: AppColors.primary, size: AppDimensions.iconLG),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.callout.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: AppTypography.caption1.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.textTertiary,
                  size: AppDimensions.iconSM,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        _buildActionButton(
          'Exporter mes données',
          Icons.download_rounded,
          AppColors.accent,
          () {
            _showExportDialog();
          },
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        _buildActionButton(
          'Partager l\'app',
          Icons.share_rounded,
          AppColors.primary,
          () {},
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        _buildActionButton(
          'Support & Aide',
          Icons.help_outline_rounded,
          AppColors.warning,
          () {},
        ),
      ],
    ).animate().fadeIn(delay: 1100.ms);
  }

  Widget _buildActionButton(String title, IconData icon, Color color, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppBorderRadius.cardRadius,
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppBorderRadius.cardRadius,
          child: Padding(
            padding: AppSpacing.cardPaddingInsets,
            child: Row(
              children: [
                Icon(icon, color: color, size: AppDimensions.iconLG),
                const SizedBox(width: AppSpacing.md),
                Text(
                  title,
                  style: AppTypography.callout.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: AppTypography.semibold,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color.withOpacity(0.7),
                  size: AppDimensions.iconSM,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.cardRadius,
        ),
        title: Text(
          'Exporter vos données',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'Vos données seront exportées au format JSON et incluront votre historique d\'humeur, sessions de méditation et statistiques.',
          style: AppTypography.body.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Annuler',
              style: AppTypography.button.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: AppColors.premiumGradient,
              borderRadius: AppBorderRadius.buttonRadius,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Simuler l'export
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Export en cours...',
                      style: AppTypography.body.copyWith(color: Colors.white),
                    ),
                    backgroundColor: AppColors.accent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: Text(
                'Exporter',
                style: AppTypography.button.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}