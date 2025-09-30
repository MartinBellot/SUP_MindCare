import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';

/// Écran ultra moderne de méditation avec design Apple-like
class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _pulseController;
  bool isBreathing = false;
  int breathingCycle = 0;
  String breathingPhase = 'Inspirez';

  final List<MeditationProgram> programs = [
    MeditationProgram(
      title: 'Respiration profonde',
      subtitle: 'Relaxation immédiate',
      duration: '3-10 min',
      icon: Icons.air_rounded,
      color: AppColors.accent,
      gradient: const LinearGradient(
        colors: [Color(0xFF667eea), Color(0xFF764ba2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    MeditationProgram(
      title: 'Méditation guidée',
      subtitle: 'Pleine conscience',
      duration: '5-20 min',
      icon: Icons.self_improvement_rounded,
      color: AppColors.primary,
      gradient: const LinearGradient(
        colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    MeditationProgram(
      title: 'Sons de la nature',
      subtitle: 'Ambiance relaxante',
      duration: '10-60 min',
      icon: Icons.nature_rounded,
      color: AppColors.accent,
      gradient: const LinearGradient(
        colors: [Color(0xFF11998e), Color(0xFF38ef7d)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    MeditationProgram(
      title: 'Méditation du sommeil',
      subtitle: 'Endormissement facile',
      duration: '15-30 min',
      icon: Icons.bedtime_rounded,
      color: AppColors.meditationSleep,
      gradient: const LinearGradient(
        colors: [Color(0xFF2C3E50), Color(0xFF4A6741)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _breathingController.addListener(() {
      if (_breathingController.value < 0.5) {
        if (breathingPhase != 'Inspirez') {
          setState(() {
            breathingPhase = 'Inspirez';
          });
        }
      } else {
        if (breathingPhase != 'Expirez') {
          setState(() {
            breathingPhase = 'Expirez';
          });
        }
      }
    });

    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          breathingCycle++;
        });
        if (isBreathing) {
          _breathingController.reset();
          _breathingController.forward();
        }
      }
    });
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleBreathing() {
    setState(() {
      isBreathing = !isBreathing;
      if (isBreathing) {
        breathingCycle = 0;
        _breathingController.forward();
      } else {
        _breathingController.stop();
        _breathingController.reset();
        breathingPhase = 'Inspirez';
      }
    });
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
                  
                  // Exercice de respiration rapide
                  _buildQuickBreathingCard(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Programmes de méditation
                  _buildMeditationPrograms(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Statistiques de méditation
                  _buildMeditationStats(),
                  
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
                'Méditation & Relaxation',
                style: AppTypography.largeTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.3),
              
              const SizedBox(height: 4),
              
              Text(
                'Trouvez votre paix intérieure',
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

  Widget _buildQuickBreathingCard() {
    return Container(
      height: 260,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppBorderRadius.cardRadius,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Motif de fond
          Positioned.fill(
            child: CustomPaint(
              painter: BreathingPatternPainter(
                animation: _pulseController,
              ),
            ),
          ),
          
          // Contenu
          Padding(
            padding: AppSpacing.cardPaddingInsets,
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: AppSpacing.paddingSM,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: AppBorderRadius.radiusLG,
                      ),
                      child: const Icon(
                        Icons.air_rounded,
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
                            'Respiration guidée',
                            style: AppTypography.callout.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Text(
                            isBreathing ? 'En cours...' : 'Prêt à commencer',
                            style: AppTypography.caption1.copyWith(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppSpacing.lg),
                
                // Cercle de respiration
                Expanded(
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _breathingController,
                      builder: (context, child) {
                        final scale = 1.0 + (_breathingController.value * 0.3);
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    breathingPhase,
                                    style: AppTypography.callout.copyWith(
                                      color: Colors.white,
                                      fontWeight: AppTypography.semibold,
                                    ),
                                  ),
                                  if (isBreathing) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      'Cycle $breathingCycle',
                                      style: AppTypography.caption1.copyWith(
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // Bouton de contrôle
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: AppBorderRadius.buttonRadius,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: _toggleBreathing,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppBorderRadius.buttonRadius,
                      ),
                    ),
                    child: Text(
                      isBreathing ? 'Arrêter' : 'Commencer',
                      style: AppTypography.button.copyWith(
                        color: Colors.white,
                        fontWeight: AppTypography.semibold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3);
  }

  Widget _buildMeditationPrograms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Programmes de méditation',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.85,
          ),
          itemCount: programs.length,
          itemBuilder: (context, index) {
            final program = programs[index];
            return _buildProgramCard(program, index);
          },
        ),
      ],
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildProgramCard(MeditationProgram program, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: program.gradient,
        borderRadius: AppBorderRadius.cardRadius,
        boxShadow: [
          BoxShadow(
            color: program.color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _startMeditationSession(program);
          },
          borderRadius: AppBorderRadius.cardRadius,
          child: Padding(
            padding: AppSpacing.cardPaddingInsets,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icône
                Container(
                  padding: AppSpacing.paddingMD,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: AppBorderRadius.radiusMD,
                  ),
                  child: Icon(
                    program.icon,
                    color: Colors.white,
                    size: AppDimensions.iconLG,
                  ),
                ),
                
                const Spacer(),
                
                // Durée
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: AppBorderRadius.radiusSM,
                  ),
                  child: Text(
                    program.duration,
                    style: AppTypography.caption1.copyWith(
                      color: Colors.white,
                      fontWeight: AppTypography.semibold,
                    ),
                  ),
                ),
                
                const SizedBox(height: AppSpacing.sm),
                
                // Titre et description
                Text(
                  program.title,
                  style: AppTypography.calloutEmphasized.copyWith(
                    color: Colors.white,
                    fontWeight: AppTypography.bold,
                  ),
                ),
                
                const SizedBox(height: 2),
                
                Text(
                  program.subtitle,
                  style: AppTypography.caption1.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: (800 + index * 100).ms).scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildMeditationStats() {
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
              Icon(
                Icons.insights_rounded,
                color: AppColors.primary,
                size: AppDimensions.iconLG,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Vos statistiques',
                style: AppTypography.title3.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.lg),
          
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Sessions', '12', Icons.self_improvement_rounded),
              ),
              Expanded(
                child: _buildStatItem('Temps total', '2h 30m', Icons.access_time_rounded),
              ),
              Expanded(
                child: _buildStatItem('Séries', '5 jours', Icons.local_fire_department_rounded),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 1000.ms);
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.accent,
          size: AppDimensions.iconLG,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          value,
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: AppTypography.bold,
          ),
        ),
        Text(
          label,
          style: AppTypography.caption1.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  void _startMeditationSession(MeditationProgram program) {
    // Animation de feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Démarrage de "${program.title}"...',
          style: AppTypography.body.copyWith(color: Colors.white),
        ),
        backgroundColor: program.color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.cardRadius,
        ),
      ),
    );
  }
}

class MeditationProgram {
  final String title;
  final String subtitle;
  final String duration;
  final IconData icon;
  final Color color;
  final LinearGradient gradient;

  MeditationProgram({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.icon,
    required this.color,
    required this.gradient,
  });
}

class BreathingPatternPainter extends CustomPainter {
  final Animation<double> animation;

  BreathingPatternPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width * 0.3) + (animation.value * 20);

    // Dessiner des cercles concentriques animés
    for (int i = 0; i < 3; i++) {
      final currentRadius = radius - (i * 30);
      if (currentRadius > 0) {
        canvas.drawCircle(center, currentRadius, paint);
      }
    }

    // Dessiner des particules flottantes
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45) + (animation.value * 360);
      final particleRadius = radius * 0.7;
      final x = center.dx + particleRadius * math.cos(angle * math.pi / 180);
      final y = center.dy + particleRadius * math.sin(angle * math.pi / 180);
      
      canvas.drawCircle(
        Offset(x, y),
        3 + (animation.value * 2),
        Paint()..color = Colors.white.withOpacity(0.3),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}