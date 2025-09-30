import 'package:flutter/material.dart';

/// Système typographique Apple-like
/// Basé sur les guidelines Apple avec SF Pro Display et SF Pro Text
class AppTypography {
  AppTypography._();

  // === FAMILLE DE POLICES ===
  
  // Utilisation des polices système
  static const String _displayFontFamily = 'Inter';
  static const String _textFontFamily = 'Inter';

  // === POIDS DE POLICE ===
  
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight heavy = FontWeight.w800;

  // === STYLES DE TITRE (LARGE DISPLAY) ===
  
  /// Titre principal de l'app - 34pt
  static const TextStyle largeTitle = TextStyle(
    fontFamily: _displayFontFamily,
    fontSize: 34,
    fontWeight: bold,
    height: 1.2,
    letterSpacing: 0.37,
  );

  /// Titre de section principale - 28pt
  static const TextStyle title1 = TextStyle(
    fontFamily: _displayFontFamily,
    fontSize: 28,
    fontWeight: bold,
    height: 1.2,
    letterSpacing: 0.36,
  );

  /// Titre de sous-section - 22pt
  static const TextStyle title2 = TextStyle(
    fontFamily: _displayFontFamily,
    fontSize: 22,
    fontWeight: bold,
    height: 1.3,
    letterSpacing: 0.35,
  );

  /// Titre de carte - 20pt
  static const TextStyle title3 = TextStyle(
    fontFamily: _displayFontFamily,
    fontSize: 20,
    fontWeight: semibold,
    height: 1.25,
    letterSpacing: 0.38,
  );

  // === STYLES DE TEXTE COURANT ===

  /// Texte de corps principal - 17pt
  static const TextStyle body = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 17,
    fontWeight: regular,
    height: 1.4,
    letterSpacing: -0.41,
  );

  /// Texte de corps avec emphasis - 17pt
  static const TextStyle bodyEmphasized = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 17,
    fontWeight: semibold,
    height: 1.4,
    letterSpacing: -0.41,
  );

  /// Texte secondaire - 15pt
  static const TextStyle callout = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 15,
    fontWeight: regular,
    height: 1.35,
    letterSpacing: -0.24,
  );

  /// Texte secondaire avec emphasis - 15pt
  static const TextStyle calloutEmphasized = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 15,
    fontWeight: semibold,
    height: 1.35,
    letterSpacing: -0.24,
  );

  /// Sous-texte - 13pt
  static const TextStyle subheadline = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 13,
    fontWeight: regular,
    height: 1.4,
    letterSpacing: -0.08,
  );

  /// Légendes et notes - 12pt
  static const TextStyle footnote = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 12,
    fontWeight: regular,
    height: 1.35,
    letterSpacing: 0.0,
  );

  /// Texte très petit - 11pt
  static const TextStyle caption1 = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 11,
    fontWeight: regular,
    height: 1.35,
    letterSpacing: 0.07,
  );

  /// Texte micro - 10pt
  static const TextStyle caption2 = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 10,
    fontWeight: regular,
    height: 1.2,
    letterSpacing: 0.12,
  );

  // === STYLES SPÉCIALISÉS ===

  /// Texte de bouton
  static const TextStyle button = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 17,
    fontWeight: semibold,
    height: 1.3,
    letterSpacing: -0.41,
  );

  /// Texte de bouton petit
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 15,
    fontWeight: semibold,
    height: 1.3,
    letterSpacing: -0.24,
  );

  /// Texte de navigation
  static const TextStyle tabBar = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 10,
    fontWeight: medium,
    height: 1.3,
    letterSpacing: 0.12,
  );

  /// Texte de navigation bar
  static const TextStyle navigationTitle = TextStyle(
    fontFamily: _displayFontFamily,
    fontSize: 17,
    fontWeight: semibold,
    height: 1.3,
    letterSpacing: -0.41,
  );

  // === STYLES POUR L'APP DE SANTÉ MENTALE ===

  /// Titre pour les statistiques importantes
  static const TextStyle statisticTitle = TextStyle(
    fontFamily: _displayFontFamily,
    fontSize: 32,
    fontWeight: bold,
    height: 1.1,
    letterSpacing: 0.37,
  );

  /// Valeur de métrique
  static const TextStyle metricValue = TextStyle(
    fontFamily: _displayFontFamily,
    fontSize: 24,
    fontWeight: semibold,
    height: 1.2,
    letterSpacing: 0.36,
  );

  /// Label de métrique
  static const TextStyle metricLabel = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 13,
    fontWeight: medium,
    height: 1.4,
    letterSpacing: -0.08,
  );

  /// Texte de citation ou message inspirant
  static const TextStyle quote = TextStyle(
    fontFamily: _textFontFamily,
    fontSize: 17,
    fontWeight: regular,
    height: 1.5,
    letterSpacing: -0.41,
    fontStyle: FontStyle.italic,
  );

  /// Titre de session de méditation
  static const TextStyle meditationTitle = TextStyle(
    fontFamily: _displayFontFamily,
    fontSize: 24,
    fontWeight: semibold,
    height: 1.25,
    letterSpacing: 0.36,
  );

  /// Timer de méditation
  static const TextStyle meditationTimer = TextStyle(
    fontFamily: _displayFontFamily,
    fontSize: 48,
    fontWeight: light,
    height: 1.0,
    letterSpacing: 0.0,
  );

  // === UTILITAIRES ===

  /// Crée une copie du style avec une couleur spécifique
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Crée une copie du style avec un poids spécifique
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Crée une copie du style avec une taille spécifique
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }

  /// Style avec gradient (nécessite un Shader)
  static TextStyle withGradient(TextStyle style) {
    return style.copyWith(
      foreground: Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFF007AFF), Color(0xFF64D2FF)],
        ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
    );
  }
}

/// Extension pour faciliter l'utilisation des styles
extension TextStyleExtensions on TextStyle {
  /// Applique une couleur
  TextStyle colored(Color color) => copyWith(color: color);
  
  /// Applique un poids
  TextStyle weighted(FontWeight weight) => copyWith(fontWeight: weight);
  
  /// Applique une taille
  TextStyle sized(double size) => copyWith(fontSize: size);
  
  /// Applique de l'italique
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
  
  /// Applique un underline
  TextStyle get underlined => copyWith(decoration: TextDecoration.underline);
}