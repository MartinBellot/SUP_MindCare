import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';

/// Écran de session de méditation ultra moderne
class MeditationSessionScreen extends StatefulWidget {
  final String programTitle;
  final int durationMinutes;
  
  const MeditationSessionScreen({
    super.key,
    required this.programTitle,
    this.durationMinutes = 10,
  });

  @override
  State<MeditationSessionScreen> createState() => _MeditationSessionScreenState();
}

class _MeditationSessionScreenState extends State<MeditationSessionScreen>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _waveController;
  late AnimationController _particleController;
  
  bool isPlaying = false;
  bool isPaused = false;
  int elapsedSeconds = 0;
  int totalSeconds = 0;
  
  String currentPhase = 'Préparation';
  List<String> meditationPhrases = [
    'Respirez profondément...',
    'Relâchez les tensions...',
    'Concentrez-vous sur votre respiration...',
    'Laissez vos pensées s\'envoler...',
    'Ressentez la paix intérieure...',
    'Vous êtes dans le moment présent...',
  ];
  int currentPhraseIndex = 0;

  @override
  void initState() {
    super.initState();
    totalSeconds = widget.durationMinutes * 60;
    
    _breathingController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    
    _waveController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    
    _particleController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    
    _startBreathingCycle();
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _waveController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  void _startBreathingCycle() {
    _breathingController.repeat();
    _breathingController.addListener(() {
      final value = _breathingController.value;
      if (value < 0.5) {
        if (currentPhase != 'Inspirez') {
          setState(() {
            currentPhase = 'Inspirez';
          });
        }
      } else {
        if (currentPhase != 'Expirez') {
          setState(() {
            currentPhase = 'Expirez';
          });
        }
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      if (isPlaying) {
        isPaused = true;
        isPlaying = false;
        _breathingController.stop();
      } else {
        isPaused = false;
        isPlaying = true;
        _breathingController.repeat();
        _startTimer();
      }
    });
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (isPlaying && mounted) {
        setState(() {
          elapsedSeconds++;
          if (elapsedSeconds % 15 == 0) {
            currentPhraseIndex = (currentPhraseIndex + 1) % meditationPhrases.length;
          }
        });
        
        if (elapsedSeconds < totalSeconds) {
          _startTimer();
        } else {
          _endSession();
        }
      }
    });
  }

  void _endSession() {
    setState(() {
      isPlaying = false;
      currentPhase = 'Session terminée';
    });
    
    _showCompletionDialog();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.cardRadius,
        ),
        title: Text(
          'Félicitations ! 🎉',
          style: AppTypography.title2.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          'Vous avez terminé votre session de méditation de ${widget.durationMinutes} minutes.',
          style: AppTypography.body.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text(
              'Terminer',
              style: AppTypography.button.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final progress = totalSeconds > 0 ? elapsedSeconds / totalSeconds : 0.0;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Fond animé
          Positioned.fill(
            child: CustomPaint(
              painter: MeditationBackgroundPainter(
                waveAnimation: _waveController,
                particleAnimation: _particleController,
              ),
            ),
          ),
          
          // Contenu principal
          SafeArea(
            child: Padding(
              padding: AppSpacing.screenHorizontalPadding,
              child: Column(
                children: [
                  // Header avec bouton retour
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded),
                        color: AppColors.textPrimary,
                      ),
                      Expanded(
                        child: Text(
                          widget.programTitle,
                          textAlign: TextAlign.center,
                          style: AppTypography.title3.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Pour équilibrer le layout
                    ],
                  ),
                  
                  const SizedBox(height: AppSpacing.xl),
                  
                  // Timer et progression
                  Text(
                    _formatTime(totalSeconds - elapsedSeconds),
                    style: AppTypography.largeTitle.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 48,
                    ),
                  ).animate().fadeIn(delay: 200.ms),
                  
                  const SizedBox(height: AppSpacing.md),
                  
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundSecondary,
                      borderRadius: AppBorderRadius.radiusSM,
                    ),
                    child: ClipRRect(
                      borderRadius: AppBorderRadius.radiusSM,
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Cercle de respiration central
                  AnimatedBuilder(
                    animation: _breathingController,
                    builder: (context, child) {
                      final scale = 1.0 + (_breathingController.value * 0.4);
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primary.withOpacity(0.3),
                                AppColors.primary.withOpacity(0.1),
                                Colors.transparent,
                              ],
                            ),
                            border: Border.all(
                              color: AppColors.primary.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary.withOpacity(0.2),
                              ),
                              child: Icon(
                                Icons.self_improvement_rounded,
                                color: AppColors.primary,
                                size: 48,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: AppSpacing.xl),
                  
                  // Phase actuelle
                  Text(
                    currentPhase,
                    style: AppTypography.title2.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: AppTypography.semibold,
                    ),
                  ).animate().fadeIn(),
                  
                  const SizedBox(height: AppSpacing.md),
                  
                  // Phrase de méditation
                  Text(
                    meditationPhrases[currentPhraseIndex],
                    textAlign: TextAlign.center,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                  
                  const Spacer(),
                  
                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bouton play/pause
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.premiumGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: _togglePlayPause,
                          icon: Icon(
                            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MeditationBackgroundPainter extends CustomPainter {
  final Animation<double> waveAnimation;
  final Animation<double> particleAnimation;

  MeditationBackgroundPainter({
    required this.waveAnimation,
    required this.particleAnimation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Dessiner des vagues subtiles
    final wavePaint = Paint()
      ..color = AppColors.primary.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = 30.0;
    final waveOffset = waveAnimation.value * 2 * math.pi;

    path.moveTo(0, size.height * 0.7);
    for (double x = 0; x <= size.width; x += 10) {
      final y = size.height * 0.7 + 
          math.sin((x / size.width * 2 * math.pi) + waveOffset) * waveHeight;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, wavePaint);

    // Dessiner des particules flottantes
    final particlePaint = Paint()
      ..color = AppColors.primary.withOpacity(0.1);

    for (int i = 0; i < 20; i++) {
      final x = (i * size.width / 20) + 
          (math.sin(particleAnimation.value * 2 * math.pi + i) * 50);
      final y = (size.height * 0.3) + 
          (math.cos(particleAnimation.value * 2 * math.pi + i * 0.5) * 100);
      final radius = 2 + (math.sin(particleAnimation.value * 4 * math.pi + i) * 2);
      
      canvas.drawCircle(Offset(x, y), radius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}