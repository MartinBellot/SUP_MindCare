import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';

enum MeditationType {
  breathing,
  bodyScan,
  visualization,
  mantra,
  nature,
  sleep,
}

/// Écran ultra moderne de méditation avec design Apple-like et thème sombre
class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _pulseController;
  late AnimationController _particlesController;
  late AnimationController _bodyController;
  
  bool isBreathing = false;
  bool isBodyScan = false;
  bool isVisualization = false;
  int breathingCycle = 0;
  int bodyScanStep = 0;
  String breathingPhase = 'Inspirez';
  String bodyScanPhase = 'Commencez par vos pieds';
  int selectedExerciseIndex = 0;

  final List<MeditationProgram> programs = [
    MeditationProgram(
      title: 'Respiration profonde',
      subtitle: 'Relaxation immédiate',
      duration: '3-10 min',
      icon: Icons.air_rounded,
      color: AppColors.meditationCalm,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF1B263B).withOpacity(0.9),
          const Color(0xFF415A77).withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      type: MeditationType.breathing,
    ),
    MeditationProgram(
      title: 'Body Scan',
      subtitle: 'Détente corporelle',
      duration: '10-20 min',
      icon: Icons.accessibility_new_rounded,
      color: AppColors.meditationFocus,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF2D1B69).withOpacity(0.9),
          const Color(0xFF11998E).withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      type: MeditationType.bodyScan,
    ),
    MeditationProgram(
      title: 'Visualisation',
      subtitle: 'Imagerie mentale',
      duration: '5-15 min',
      icon: Icons.visibility_rounded,
      color: AppColors.meditationEnergy,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF7209B7).withOpacity(0.9),
          const Color(0xFFFF6B6B).withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      type: MeditationType.visualization,
    ),
    MeditationProgram(
      title: 'Mantras',
      subtitle: 'Répétition sacrée',
      duration: '5-30 min',
      icon: Icons.record_voice_over_rounded,
      color: AppColors.accent,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF134E5E).withOpacity(0.9),
          const Color(0xFF71B280).withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      type: MeditationType.mantra,
    ),
    MeditationProgram(
      title: 'Sons de la nature',
      subtitle: 'Ambiance relaxante',
      duration: '10-60 min',
      icon: Icons.nature_rounded,
      color: AppColors.accent,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF134E5E).withOpacity(0.9),
          const Color(0xFF71B280).withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      type: MeditationType.nature,
    ),
    MeditationProgram(
      title: 'Méditation du sommeil',
      subtitle: 'Endormissement facile',
      duration: '15-30 min',
      icon: Icons.bedtime_rounded,
      color: AppColors.meditationSleep,
      gradient: LinearGradient(
        colors: [
          const Color(0xFF2C1810).withOpacity(0.9),
          const Color(0xFF5C4A72).withOpacity(0.8),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      type: MeditationType.sleep,
    ),
  ];

  final List<String> bodyScanSteps = [
    'Commencez par vos pieds',
    'Remontez vers vos jambes',
    'Détendez votre bassin',
    'Relâchez votre abdomen',
    'Libérez votre poitrine',
    'Détendez vos bras',
    'Relâchez vos épaules',
    'Libérez votre cou',
    'Détendez votre visage',
    'Tout votre corps est relaxé',
  ];

  final List<String> mantras = [
    'Je suis en paix',
    'Je suis présent',
    'Je respire la sérénité',
    'Je lâche prise',
    'Je suis reconnaissant',
    'Je m\'aime tel que je suis',
  ];

  final List<String> visualizations = [
    'Imaginez un lac paisible',
    'Visualisez une forêt sereine',
    'Pensez à un coucher de soleil',
    'Imaginez des vagues douces',
    'Visualisez un jardin fleuri',
    'Pensez à un ciel étoilé',
  ];

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    
    _particlesController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    
    _bodyController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

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

    _bodyController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isBodyScan) {
        setState(() {
          bodyScanStep = (bodyScanStep + 1) % bodyScanSteps.length;
          bodyScanPhase = bodyScanSteps[bodyScanStep];
        });
        Future.delayed(const Duration(seconds: 1), () {
          if (isBodyScan) {
            _bodyController.reset();
            _bodyController.forward();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _pulseController.dispose();
    _particlesController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _toggleBreathing() {
    setState(() {
      _stopAllExercises();
      isBreathing = !isBreathing;
      if (isBreathing) {
        breathingCycle = 0;
        selectedExerciseIndex = 0;
        _breathingController.forward();
        HapticFeedback.mediumImpact();
      } else {
        _breathingController.stop();
        _breathingController.reset();
        breathingPhase = 'Inspirez';
      }
    });
  }

  void _toggleBodyScan() {
    setState(() {
      _stopAllExercises();
      isBodyScan = !isBodyScan;
      if (isBodyScan) {
        bodyScanStep = 0;
        bodyScanPhase = bodyScanSteps[0];
        selectedExerciseIndex = 1;
        _bodyController.forward();
        HapticFeedback.mediumImpact();
      } else {
        _bodyController.stop();
        _bodyController.reset();
      }
    });
  }

  void _toggleVisualization() {
    setState(() {
      _stopAllExercises();
      isVisualization = !isVisualization;
      if (isVisualization) {
        selectedExerciseIndex = 2;
        HapticFeedback.mediumImpact();
      }
    });
  }

  void _stopAllExercises() {
    isBreathing = false;
    isBodyScan = false;
    isVisualization = false;
    _breathingController.stop();
    _breathingController.reset();
    _bodyController.stop();
    _bodyController.reset();
    breathingPhase = 'Inspirez';
    bodyScanPhase = 'Commencez par vos pieds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Fond animé avec particules
          _buildAnimatedBackground(),
          
          // Contenu principal
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // App Bar moderne
                _buildModernAppBar(),
                
                // Contenu principal
                SliverPadding(
                  padding: AppSpacing.screenHorizontalPadding,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Sélecteur d'exercices
                      _buildExerciseSelector(),
                      
                      const SizedBox(height: AppSpacing.sectionSpacing),
                      
                      // Exercice actuel
                      _buildCurrentExercise(),
                      
                      const SizedBox(height: AppSpacing.sectionSpacing),
                      
                      // Programmes de méditation
                      _buildMeditationPrograms(),
                      
                      const SizedBox(height: AppSpacing.sectionSpacing),
                      
                      // Statistiques avancées
                      _buildAdvancedStats(),
                      
                      const SizedBox(height: 120),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _particlesController,
        builder: (context, child) {
          return CustomPaint(
            painter: ParticleBackgroundPainter(
              animation: _particlesController,
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.background.withOpacity(0.9),
                AppColors.background.withOpacity(0.0),
              ],
            ),
          ),
          child: Padding(
            padding: AppSpacing.screenHorizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.spa_rounded,
                        color: AppColors.primary,
                        size: AppDimensions.iconLG,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Méditation',
                            style: AppTypography.largeTitle.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Votre sanctuaire intérieur',
                            style: AppTypography.body.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseSelector() {
    final exercises = ['Respiration', 'Body Scan', 'Visualisation'];
    
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.borderSecondary,
          width: 0.5,
        ),
      ),
      child: Row(
        children: exercises.asMap().entries.map((entry) {
          final index = entry.key;
          final exercise = entry.value;
          final isSelected = selectedExerciseIndex == index;
          
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedExerciseIndex = index;
                  _stopAllExercises();
                });
                HapticFeedback.lightImpact();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ] : null,
                ),
                child: Center(
                  child: Text(
                    exercise,
                    style: AppTypography.callout.copyWith(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3);
  }

  Widget _buildCurrentExercise() {
    switch (selectedExerciseIndex) {
      case 0:
        return _buildBreathingExercise();
      case 1:
        return _buildBodyScanExercise();
      case 2:
        return _buildVisualizationExercise();
      default:
        return _buildBreathingExercise();
    }
  }

  Widget _buildBreathingExercise() {
    return Container(
      height: 520,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1B263B).withOpacity(0.9),
            const Color(0xFF415A77).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B263B).withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Motif de fond animé
          Positioned.fill(
            child: CustomPaint(
              painter: BreathingPatternPainter(
                animation: _pulseController,
              ),
            ),
          ),
          
          // Contenu
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.air_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Respiration profonde',
                            style: AppTypography.title3.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            isBreathing ? '$breathingCycle cycles complétés' : 'Prêt à commencer',
                            style: AppTypography.caption1.copyWith(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Cercle de respiration
                Expanded(
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _breathingController,
                      builder: (context, child) {
                        final scale = 1.0 + (_breathingController.value * 0.4);
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.6),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    breathingPhase,
                                    style: AppTypography.title3.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (isBreathing) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      '${(_breathingController.value * 8).toInt() + 1}s',
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
                _buildControlButton(
                  onPressed: _toggleBreathing,
                  isActive: isBreathing,
                  label: isBreathing ? 'Arrêter' : 'Commencer',
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3);
  }

  Widget _buildBodyScanExercise() {
    return Container(
      height: 520,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2D1B69).withOpacity(0.9),
            const Color(0xFF11998E).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D1B69).withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.accessibility_new_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Body Scan',
                        style: AppTypography.title3.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        isBodyScan ? 'Étape ${bodyScanStep + 1}/${bodyScanSteps.length}' : 'Prêt à commencer',
                        style: AppTypography.caption1.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Illustration du corps
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: _bodyController,
                  builder: (context, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(60),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.6),
                              width: 2,
                            ),
                          ),
                          child: CustomPaint(
                            painter: BodyScanPainter(
                              animation: _bodyController,
                              currentStep: bodyScanStep,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          bodyScanPhase,
                          style: AppTypography.title3.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            
            // Bouton de contrôle
            _buildControlButton(
              onPressed: _toggleBodyScan,
              isActive: isBodyScan,
              label: isBodyScan ? 'Arrêter' : 'Commencer',
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3);
  }

  Widget _buildVisualizationExercise() {
    return Container(
      height: 520,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF7209B7).withOpacity(0.9),
            const Color(0xFFFF6B6B).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7209B7).withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.visibility_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Visualisation',
                        style: AppTypography.title3.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Imagerie mentale guidée',
                        style: AppTypography.caption1.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Zone de visualisation
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    return Container(
                      width: 160,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_red_eye_rounded,
                            color: Colors.white.withOpacity(0.8),
                            size: 40,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            visualizations[(_pulseController.value * visualizations.length).floor() % visualizations.length],
                            style: AppTypography.callout.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Bouton de contrôle
            _buildControlButton(
              onPressed: _toggleVisualization,
              isActive: isVisualization,
              label: isVisualization ? 'Arrêter' : 'Commencer',
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3);
  }

  Widget _buildControlButton({
    required VoidCallback onPressed,
    required bool isActive,
    required String label,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(isActive ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? Icons.stop_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTypography.button.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeditationPrograms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.library_music_rounded,
              color: AppColors.primary,
              size: AppDimensions.iconLG,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Programmes de méditation',
              style: AppTypography.title3.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: program.color.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _startMeditationSession(program);
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icône
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
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
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    program.duration,
                    style: AppTypography.caption1.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                
                const SizedBox(height: AppSpacing.sm),
                
                // Titre et description
                Text(
                  program.title,
                  style: AppTypography.calloutEmphasized.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                
                const SizedBox(height: 4),
                
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

  Widget _buildAdvancedStats() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(24),
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.insights_rounded,
                  color: AppColors.primary,
                  size: AppDimensions.iconLG,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vos statistiques',
                    style: AppTypography.title3.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Progression personnelle',
                    style: AppTypography.caption1.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.xl),
          
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Sessions', '24', Icons.self_improvement_rounded, AppColors.primary),
              ),
              Expanded(
                child: _buildStatItem('Temps total', '5h 12m', Icons.access_time_rounded, AppColors.accent),
              ),
              Expanded(
                child: _buildStatItem('Séries', '8 jours', Icons.local_fire_department_rounded, AppColors.meditationEnergy),
              ),
            ],
          ),
          
          const SizedBox(height: AppSpacing.lg),
          
          // Barre de progression
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundTertiary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Objectif hebdomadaire',
                      style: AppTypography.callout.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '5/7 jours',
                      style: AppTypography.callout.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: 5/7,
                  backgroundColor: AppColors.borderSecondary,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  borderRadius: BorderRadius.circular(8),
                  minHeight: 6,
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 1000.ms);
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: color,
            size: AppDimensions.iconLG,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          value,
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
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
    HapticFeedback.heavyImpact();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              program.icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Démarrage de "${program.title}"...',
                style: AppTypography.body.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: program.color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
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
  final MeditationType type;

  MeditationProgram({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.icon,
    required this.color,
    required this.gradient,
    required this.type,
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
    final baseRadius = size.width * 0.2;

    // Dessiner des cercles concentriques animés
    for (int i = 0; i < 4; i++) {
      final animationOffset = (animation.value + i * 0.25) % 1.0;
      final radius = baseRadius + (animationOffset * 60);
      final opacity = 1.0 - animationOffset;
      
      if (radius < size.width * 0.6) {
        canvas.drawCircle(
          center, 
          radius, 
          paint..color = Colors.white.withOpacity(opacity * 0.2)
        );
      }
    }

    // Dessiner des particules flottantes
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) + (animation.value * 360);
      final particleRadius = baseRadius * 1.2;
      final x = center.dx + particleRadius * math.cos(angle * math.pi / 180);
      final y = center.dy + particleRadius * math.sin(angle * math.pi / 180);
      
      canvas.drawCircle(
        Offset(x, y),
        2 + (math.sin(animation.value * 2 * math.pi + i) * 1),
        Paint()..color = Colors.white.withOpacity(0.4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ParticleBackgroundPainter extends CustomPainter {
  final Animation<double> animation;

  ParticleBackgroundPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.primary.withOpacity(0.03);

    // Créer des particules flottantes dans le fond
    for (int i = 0; i < 20; i++) {
      final x = (i * 37.5) % size.width;
      final y = ((i * 51.3 + animation.value * 200) % size.height);
      final radius = 1.0 + (i % 3).toDouble();
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Dessiner des lignes subtiles
    final linePaint = Paint()
      ..color = AppColors.borderSecondary.withOpacity(0.1)
      ..strokeWidth = 0.5;

    for (int i = 0; i < 5; i++) {
      final y = (i * size.height / 4) + (animation.value * 50);
      canvas.drawLine(
        Offset(0, y % size.height),
        Offset(size.width, (y + 20) % size.height),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BodyScanPainter extends CustomPainter {
  final Animation<double> animation;
  final int currentStep;

  BodyScanPainter({required this.animation, required this.currentStep});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    
    // Dessiner une silhouette simple du corps
    final bodyParts = [
      Rect.fromCenter(center: Offset(center.dx, size.height * 0.9), width: 20, height: 10), // Pieds
      Rect.fromCenter(center: Offset(center.dx, size.height * 0.75), width: 25, height: 20), // Jambes
      Rect.fromCenter(center: Offset(center.dx, size.height * 0.6), width: 30, height: 15), // Bassin
      Rect.fromCenter(center: Offset(center.dx, size.height * 0.45), width: 28, height: 18), // Abdomen
      Rect.fromCenter(center: Offset(center.dx, size.height * 0.3), width: 35, height: 20), // Poitrine
      Rect.fromCenter(center: Offset(center.dx, size.height * 0.2), width: 40, height: 12), // Bras
      Rect.fromCenter(center: Offset(center.dx, size.height * 0.15), width: 25, height: 8), // Épaules
      Rect.fromCenter(center: Offset(center.dx, size.height * 0.1), width: 20, height: 6), // Cou
      Rect.fromCenter(center: Offset(center.dx, size.height * 0.05), width: 22, height: 12), // Visage
    ];

    for (int i = 0; i < bodyParts.length; i++) {
      final opacity = i == currentStep ? 
        0.8 + (math.sin(animation.value * 2 * math.pi) * 0.2) : 0.3;
      
      canvas.drawRRect(
        RRect.fromRectAndRadius(bodyParts[i], const Radius.circular(8)),
        paint..color = Colors.white.withOpacity(opacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}