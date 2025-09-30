import 'package:flutter/material.dart';

/// Système de couleurs Apple-like pour dark theme
/// Inspiré des couleurs iOS et macOS avec une approche moderne
class AppColors {
  AppColors._();

  // === COULEURS PRIMAIRES ===
  
  /// Bleu système Apple - utilisé pour les actions primaires
  static const Color primary = Color(0xFF007AFF);
  static const Color primaryVariant = Color(0xFF0051D5);
  
  /// Couleurs d'accent pour le bien-être
  static const Color accent = Color(0xFF30D158); // Vert système Apple
  static const Color accentSecondary = Color(0xFF64D2FF); // Bleu clair
  
  // === COULEURS FONCTIONNELLES ===
  
  /// Rouge pour les alertes et dangers
  static const Color destructive = Color(0xFFFF453A);
  static const Color destructiveBackground = Color(0xFF5C1C1C);
  
  /// Orange pour les avertissements
  static const Color warning = Color(0xFFFF9F0A);
  static const Color warningBackground = Color(0xFF5C3B1C);
  
  /// Couleurs pour le tracking d'humeur
  static const Color moodExcellent = Color(0xFF30D158);
  static const Color moodGood = Color(0xFF32D74B);
  static const Color moodNeutral = Color(0xFFFFD60A);
  static const Color moodPoor = Color(0xFFFF9F0A);
  static const Color moodTerrible = Color(0xFFFF453A);
  
  // === COULEURS DE FOND DARK THEME ===
  
  /// Fond principal de l'app
  static const Color background = Color(0xFF000000);
  
  /// Fond secondaire pour les cartes et sections
  static const Color backgroundSecondary = Color(0xFF1C1C1E);
  
  /// Fond tertiaire pour les éléments groupés
  static const Color backgroundTertiary = Color(0xFF2C2C2E);
  
  /// Fond pour les éléments élevés (modals, sheets)
  static const Color backgroundElevated = Color(0xFF2C2C2E);
  
  /// Fond pour les inputs et contrôles
  static const Color backgroundControl = Color(0xFF3A3A3C);
  
  // === COULEURS DE TEXTE ===
  
  /// Texte principal - haute lisibilité
  static const Color textPrimary = Color(0xFFFFFFFF);
  
  /// Texte secondaire - lisibilité moyenne
  static const Color textSecondary = Color(0x99FFFFFF); // 60% opacity
  
  /// Texte tertiaire - faible lisibilité
  static const Color textTertiary = Color(0x4DFFFFFF); // 30% opacity
  
  /// Texte sur couleur (blanc sur fond coloré)
  static const Color textOnColor = Color(0xFFFFFFFF);
  
  /// Texte inversé (pour mode clair si nécessaire)
  static const Color textInverse = Color(0xFF000000);
  
  // === COULEURS DE BORDURE ET SÉPARATEURS ===
  
  /// Bordures principales
  static const Color border = Color(0xFF3A3A3C);
  
  /// Bordures secondaires plus subtiles
  static const Color borderSecondary = Color(0xFF2C2C2E);
  
  /// Séparateurs fins
  static const Color separator = Color(0xFF38383A);
  
  // === COULEURS D'ÉTAT D'INTERACTION ===
  
  /// État survolé/pressé
  static const Color surfaceHover = Color(0xFF3A3A3C);
  
  /// État sélectionné
  static const Color surfaceSelected = Color(0xFF48484A);
  
  /// État désactivé
  static const Color surfaceDisabled = Color(0xFF2C2C2E);
  
  // === COULEURS POUR GRAPHIQUES ET VISUALISATIONS ===
  
  /// Palette pour les graphiques de bien-être
  static const List<Color> chartColors = [
    Color(0xFF007AFF), // Bleu
    Color(0xFF30D158), // Vert
    Color(0xFFFF9F0A), // Orange
    Color(0xFFFF453A), // Rouge
    Color(0xFF64D2FF), // Bleu clair
    Color(0xFFBF5AF2), // Violet
    Color(0xFFFF2D92), // Rose
    Color(0xFF5AC8FA), // Cyan
  ];
  
  /// Gradient pour les éléments premium
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFF007AFF), Color(0xFF64D2FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Gradient pour les éléments de bien-être
  static const LinearGradient wellnessGradient = LinearGradient(
    colors: [Color(0xFF30D158), Color(0xFF32D74B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// Gradient pour les alertes
  static const LinearGradient alertGradient = LinearGradient(
    colors: [Color(0xFFFF453A), Color(0xFFFF6961)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // === OPACITÉS STANDARD ===
  
  /// Opacité pour les éléments désactivés
  static const double disabledOpacity = 0.3;
  
  /// Opacité pour les éléments semi-transparents
  static const double subtleOpacity = 0.6;
  
  /// Opacité pour les overlays
  static const double overlayOpacity = 0.4;
  
  // === COULEURS CONTEXTUELLES ===
  
  /// Couleurs pour différents types de méditation
  static const Color meditationCalm = Color(0xFF64D2FF);
  static const Color meditationFocus = Color(0xFF007AFF);
  static const Color meditationSleep = Color(0xFFBF5AF2);
  static const Color meditationEnergy = Color(0xFFFF9F0A);
  
  /// Couleurs pour les niveaux de stress
  static const Color stressLow = Color(0xFF30D158);
  static const Color stressMedium = Color(0xFFFFD60A);
  static const Color stressHigh = Color(0xFFFF9F0A);
  static const Color stressCritical = Color(0xFFFF453A);
}

/// Extension pour des couleurs avec opacité
extension AppColorsOpacity on Color {
  /// Retourne la couleur avec l'opacité spécifiée
  Color withOpacityValue(double opacity) {
    return withOpacity(opacity);
  }
}