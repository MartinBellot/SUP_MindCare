import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/theme.dart';
import '../../core/services/daily_quote_service.dart';

/// Widget pour afficher la citation du jour avec un design inspirant
class DailyQuoteCard extends StatefulWidget {
  const DailyQuoteCard({super.key});

  @override
  State<DailyQuoteCard> createState() => _DailyQuoteCardState();
}

class _DailyQuoteCardState extends State<DailyQuoteCard> {
  final DailyQuoteService _quoteService = DailyQuoteService();
  late String _currentQuote;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _currentQuote = _quoteService.getDailyQuote();
  }

  void _refreshQuote() async {
    setState(() {
      _isRefreshing = true;
    });
    
    // Petit délai pour l'animation
    await Future.delayed(const Duration(milliseconds: 300));
    
    setState(() {
      _currentQuote = _quoteService.getRandomQuote();
      _isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.accent.withOpacity(0.05),
          ],
        ),
        borderRadius: AppBorderRadius.cardRadius,
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: AppSpacing.cardPaddingInsets,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête avec icône et titre
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    borderRadius: AppBorderRadius.radiusCircular,
                  ),
                  child: Icon(
                    Icons.format_quote_rounded,
                    color: AppColors.primary,
                    size: AppDimensions.iconMD,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Citation du jour',
                        style: AppTypography.title3.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: AppTypography.semibold,
                        ),
                      ),
                      Text(
                        'Votre dose quotidienne de positivité',
                        style: AppTypography.caption1.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Bouton refresh
                GestureDetector(
                  onTap: _refreshQuote,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: AppBorderRadius.radiusCircular,
                    ),
                    child: AnimatedRotation(
                      turns: _isRefreshing ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.refresh_rounded,
                        color: AppColors.accent,
                        size: AppDimensions.iconMD,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                // Petite icône de cœur pour l'aspect inspirant
                Icon(
                  Icons.favorite_rounded,
                  color: AppColors.accent.withOpacity(0.6),
                  size: AppDimensions.iconSM,
                ),
              ],
            ),
            
            const SizedBox(height: AppSpacing.lg),
            
            // Citation principale
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                //color: Colors.white.withOpacity(0.7),
                borderRadius: AppBorderRadius.radiusMD,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Guillemets d'ouverture
                  Row(
                    children: [
                      Icon(
                        Icons.format_quote,
                        color: AppColors.primary.withOpacity(0.4),
                        size: 20,
                      ),
                    ],
                  ),
                  
                  // Texte de la citation
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        _currentQuote,
                        key: ValueKey(_currentQuote),
                        style: AppTypography.body.copyWith(
                          color: AppColors.textPrimary,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  
                  // Guillemets de fermeture
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.flip(
                        flipX: true,
                        child: Icon(
                          Icons.format_quote,
                          color: AppColors.primary.withOpacity(0.4),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppSpacing.md),
            
            // Bas de la carte avec action optionnelle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: AppTypography.caption2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.accent,
                      size: AppDimensions.iconSM,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _isRefreshing ? 'Inspiration...' : 'Inspirez-vous',
                      style: AppTypography.caption1.copyWith(
                        color: AppColors.accent,
                        fontWeight: AppTypography.medium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1);
  }
}