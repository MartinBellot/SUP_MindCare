import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/theme.dart';

/// Widget des actions rapides avec design ultra moderne
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      alignment: WrapAlignment.spaceBetween,
      children: [
        _QuickActionCard(
          icon: Icons.favorite_rounded,
          title: 'Humeur',
          subtitle: 'Comment allez-vous ?',
          gradient: const LinearGradient(
            colors: [Color(0xFFff9a9e), Color(0xFFfecfef)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          onTap: () {
            context.push('/mood');
          },
        ).animate().fadeIn(delay: 100.ms).scale(begin: const Offset(0.8, 0.8)),
        
        _QuickActionCard(
          icon: Icons.self_improvement_rounded,
          title: 'Méditer',
          subtitle: '5-20 minutes',
          gradient: const LinearGradient(
            colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          onTap: () {
            context.push('/meditation');
          },
        ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.8, 0.8)),
        
        _QuickActionCard(
          icon: Icons.air_rounded,
          title: 'Respirer',
          subtitle: '2-10 minutes',
          gradient: const LinearGradient(
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          onTap: () {
            // Navigation vers exercice de respiration
          },
        ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.8, 0.8)),
        
        _QuickActionCard(
          icon: Icons.insights_rounded,
          title: 'Analyse',
          subtitle: 'Vos progrès',
          gradient: const LinearGradient(
            colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          onTap: () {
            context.push('/analytics');
          },
        ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.8, 0.8)),
      ],
    );
  }
}

class _QuickActionCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  State<_QuickActionCard> createState() => _QuickActionCardState();
}

class _QuickActionCardState extends State<_QuickActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: AppBorderRadius.cardRadius,
              boxShadow: [
                BoxShadow(
                  color: widget.gradient.colors.first.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _scaleController.forward().then((_) {
                    _scaleController.reverse();
                    widget.onTap();
                  });
                },
                onTapDown: (_) => _scaleController.forward(),
                onTapCancel: () => _scaleController.reverse(),
                borderRadius: AppBorderRadius.cardRadius,
                child: Padding(
                  padding: AppSpacing.paddingLG,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icône avec effet glassmorphism
                      Container(
                        padding: AppSpacing.paddingMD,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: AppBorderRadius.radiusLG,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          widget.icon,
                          color: Colors.white,
                          size: AppDimensions.iconXL,
                        ),
                      ),
                      
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Texte
                      Text(
                        widget.title,
                        style: AppTypography.calloutEmphasized.copyWith(
                          color: Colors.white,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      
                      const SizedBox(height: 2),
                      
                      Text(
                        widget.subtitle,
                        style: AppTypography.caption1.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}