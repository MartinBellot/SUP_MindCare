import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';

/// Écran ultra moderne de suivi d'humeur avec design Apple-like
class MoodTrackingScreen extends StatefulWidget {
  const MoodTrackingScreen({super.key});

  @override
  State<MoodTrackingScreen> createState() => _MoodTrackingScreenState();
}

class _MoodTrackingScreenState extends State<MoodTrackingScreen>
    with TickerProviderStateMixin {
  int selectedMood = 3;
  int selectedEnergy = 3;
  int selectedStress = 3;
  int selectedSleep = 3;
  String notes = '';
  
  late AnimationController _heroController;
  late AnimationController _cardController;

  final List<MoodOption> moodOptions = [
    MoodOption(emoji: '😢', label: 'Très difficile', value: 1, color: AppColors.moodTerrible),
    MoodOption(emoji: '😞', label: 'Difficile', value: 2, color: AppColors.moodPoor),
    MoodOption(emoji: '😐', label: 'Neutre', value: 3, color: AppColors.moodNeutral),
    MoodOption(emoji: '🙂', label: 'Bonne', value: 4, color: AppColors.moodGood),
    MoodOption(emoji: '😊', label: 'Excellente', value: 5, color: AppColors.moodExcellent),
  ];

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _heroController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _cardController.forward();
    });
  }

  @override
  void dispose() {
    _heroController.dispose();
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
                  
                  // Hero card avec humeur sélectionnée
                  _buildMoodHeroCard(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Sélecteur d'humeur
                  _buildMoodSelector(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Métriques détaillées
                  _buildDetailedMetrics(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Notes
                  _buildNotesSection(),
                  
                  const SizedBox(height: AppSpacing.sectionSpacing),
                  
                  // Bouton de sauvegarde
                  _buildSaveButton(),
                  
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
                'Comment vous sentez-vous ?',
                style: AppTypography.largeTitle.copyWith(
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.3),
              
              const SizedBox(height: 4),
              
              Text(
                'Prenez un moment pour évaluer votre état',
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

  Widget _buildMoodHeroCard() {
    final selectedMoodOption = moodOptions[selectedMood - 1];
    
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            selectedMoodOption.color,
            selectedMoodOption.color.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppBorderRadius.cardRadius,
        boxShadow: [
          BoxShadow(
            color: selectedMoodOption.color.withOpacity(0.3),
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
              painter: MoodPatternPainter(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          
          // Contenu
          Padding(
            padding: AppSpacing.cardPaddingInsets,
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
                            'Humeur actuelle',
                            style: AppTypography.callout.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Text(
                            DateTime.now().day.toString().padLeft(2, '0') + 
                            '/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}',
                            style: AppTypography.caption1.copyWith(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const Spacer(),
                
                // Emoji et description
                Row(
                  children: [
                    Text(
                      selectedMoodOption.emoji,
                      style: const TextStyle(fontSize: 64),
                    ).animate().scale(delay: 300.ms, duration: 600.ms),
                    
                    const SizedBox(width: AppSpacing.xl),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedMoodOption.label,
                            style: AppTypography.title2.copyWith(
                              color: Colors.white,
                              fontWeight: AppTypography.bold,
                            ),
                          ),
                          Text(
                            'Niveau $selectedMood/5',
                            style: AppTypography.body.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildMoodSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sélectionnez votre humeur',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: moodOptions.map((option) {
            final isSelected = selectedMood == option.value;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedMood = option.value;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                  horizontal: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected 
                    ? option.color.withOpacity(0.15)
                    : Colors.transparent,
                  borderRadius: AppBorderRadius.radiusLG,
                  border: Border.all(
                    color: isSelected 
                      ? option.color 
                      : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      option.emoji,
                      style: TextStyle(
                        fontSize: isSelected ? 36 : 28,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      option.value.toString(),
                      style: AppTypography.caption1.copyWith(
                        color: isSelected 
                          ? option.color 
                          : AppColors.textSecondary,
                        fontWeight: isSelected 
                          ? AppTypography.semibold 
                          : AppTypography.regular,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildDetailedMetrics() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Détails supplémentaires',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        _buildMetricSlider(
          'Niveau d\'énergie',
          Icons.battery_charging_full_rounded,
          selectedEnergy,
          AppColors.accent,
          (value) => setState(() => selectedEnergy = value),
        ),
        
        const SizedBox(height: AppSpacing.lg),
        
        _buildMetricSlider(
          'Niveau de stress',
          Icons.spa_rounded,
          selectedStress,
          AppColors.warning,
          (value) => setState(() => selectedStress = value),
        ),
        
        const SizedBox(height: AppSpacing.lg),
        
        _buildMetricSlider(
          'Qualité du sommeil',
          Icons.bedtime_rounded,
          selectedSleep,
          AppColors.meditationSleep,
          (value) => setState(() => selectedSleep = value),
        ),
      ],
    ).animate().fadeIn(delay: 600.ms);
  }

  Widget _buildMetricSlider(
    String title,
    IconData icon,
    int value,
    Color color,
    Function(int) onChanged,
  ) {
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
              Icon(icon, color: color, size: AppDimensions.iconLG),
              const SizedBox(width: AppSpacing.sm),
              Text(
                title,
                style: AppTypography.calloutEmphasized.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: AppBorderRadius.radiusSM,
                ),
                child: Text(
                  '$value/5',
                  style: AppTypography.caption1.copyWith(
                    color: color,
                    fontWeight: AppTypography.semibold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              inactiveTrackColor: color.withOpacity(0.3),
              thumbColor: color,
              overlayColor: color.withOpacity(0.2),
              trackHeight: 6,
            ),
            child: Slider(
              value: value.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              onChanged: (val) => onChanged(val.round()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes personnelles (optionnel)',
          style: AppTypography.title3.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: AppBorderRadius.cardRadius,
            border: Border.all(
              color: AppColors.borderSecondary,
              width: 0.5,
            ),
          ),
          child: TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Comment s\'est passée votre journée ? Qu\'est-ce qui a influencé votre humeur ?',
              border: InputBorder.none,
              contentPadding: AppSpacing.cardPaddingInsets,
              hintStyle: AppTypography.body.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
            style: AppTypography.body.copyWith(
              color: AppColors.textPrimary,
            ),
            onChanged: (value) => notes = value,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 800.ms);
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: AppColors.premiumGradient,
        borderRadius: AppBorderRadius.buttonRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Sauvegarder l'entrée d'humeur
          _saveMoodEntry();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.buttonRadius,
          ),
        ),
        child: Text(
          'Enregistrer mon humeur',
          style: AppTypography.button.copyWith(
            color: Colors.white,
            fontWeight: AppTypography.semibold,
          ),
        ),
      ),
    ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.3);
  }

  void _saveMoodEntry() {
    // Animation de succès
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Humeur enregistrée avec succès !',
          style: AppTypography.body.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.cardRadius,
        ),
      ),
    );
    
    // Retour à l'écran précédent après un délai
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pop();
    });
  }
}

class MoodOption {
  final String emoji;
  final String label;
  final int value;
  final Color color;

  MoodOption({
    required this.emoji,
    required this.label,
    required this.value,
    required this.color,
  });
}

class MoodPatternPainter extends CustomPainter {
  final Color color;

  MoodPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Créer un motif de cœurs subtils
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 4; j++) {
        final x = (size.width / 5) * i;
        final y = (size.height / 3) * j;
        _drawHeart(canvas, paint, Offset(x, y), 15.0 - (i * 1.5));
      }
    }
  }

  void _drawHeart(Canvas canvas, Paint paint, Offset center, double size) {
    final path = Path();
    path.moveTo(center.dx, center.dy + size * 0.3);
    path.cubicTo(
      center.dx - size * 0.5, center.dy - size * 0.3,
      center.dx - size, center.dy + size * 0.1,
      center.dx, center.dy + size * 0.7,
    );
    path.cubicTo(
      center.dx + size, center.dy + size * 0.1,
      center.dx + size * 0.5, center.dy - size * 0.3,
      center.dx, center.dy + size * 0.3,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}