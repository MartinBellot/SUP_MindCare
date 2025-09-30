import 'package:flutter/material.dart';
import '../../core/theme/theme.dart';

/// Widget de progression circulaire animée pour le bien-être
class AnimatedWellnessRing extends StatefulWidget {
  final double progress; // 0.0 to 1.0
  final Color color;
  final double size;
  final String label;
  final String value;

  const AnimatedWellnessRing({
    super.key,
    required this.progress,
    required this.color,
    this.size = 120,
    required this.label,
    required this.value,
  });

  @override
  State<AnimatedWellnessRing> createState() => _AnimatedWellnessRingState();
}

class _AnimatedWellnessRingState extends State<AnimatedWellnessRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Ring de fond
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 8,
              color: widget.color.withOpacity(0.1),
              backgroundColor: Colors.transparent,
            ),
          ),
          
          // Ring de progression animé
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return SizedBox(
                width: widget.size,
                height: widget.size,
                child: CircularProgressIndicator(
                  value: _progressAnimation.value,
                  strokeWidth: 8,
                  color: widget.color,
                  backgroundColor: Colors.transparent,
                  strokeCap: StrokeCap.round,
                ),
              );
            },
          ),
          
          // Contenu central
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.value,
                style: AppTypography.metricValue.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                ),
              ),
              Text(
                widget.label,
                style: AppTypography.caption1.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}