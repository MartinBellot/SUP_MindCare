import 'package:flutter/material.dart';

/// Système de spacing Apple-like
/// Basé sur une grille de 4pt pour la cohérence
class AppSpacing {
  AppSpacing._();

  // === SPACING DE BASE ===
  
  /// Espace minimal - 4pt
  static const double xs = 4.0;
  
  /// Petit espace - 8pt
  static const double sm = 8.0;
  
  /// Espace medium - 12pt
  static const double md = 12.0;
  
  /// Espace standard - 16pt
  static const double lg = 16.0;
  
  /// Grand espace - 20pt
  static const double xl = 20.0;
  
  /// Très grand espace - 24pt
  static const double xxl = 24.0;
  
  /// Espace géant - 32pt
  static const double xxxl = 32.0;
  
  /// Espace énorme - 40pt
  static const double huge = 40.0;
  
  /// Espace massif - 48pt
  static const double massive = 48.0;

  // === MARGES SPÉCIFIQUES ===
  
  /// Marge des bords d'écran
  static const double screenHorizontal = 20.0;
  static const double screenVertical = 16.0;
  
  /// Marge des cartes
  static const double cardPadding = 16.0;
  static const double cardMargin = 12.0;
  
  /// Espacement des sections
  static const double sectionSpacing = 32.0;
  
  /// Espacement des éléments de liste
  static const double listItemSpacing = 12.0;
  
  /// Espacement des boutons
  static const double buttonSpacing = 16.0;

  // === EDGE INSETS PRÉDÉFINIS ===
  
  /// Padding minimal
  static const EdgeInsets paddingXS = EdgeInsets.all(xs);
  
  /// Padding petit
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);
  
  /// Padding medium
  static const EdgeInsets paddingMD = EdgeInsets.all(md);
  
  /// Padding standard
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);
  
  /// Padding grand
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);
  
  /// Padding très grand
  static const EdgeInsets paddingXXL = EdgeInsets.all(xxl);
  
  /// Padding des écrans
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );
  
  /// Padding horizontal des écrans
  static const EdgeInsets screenHorizontalPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );
  
  /// Padding vertical des écrans
  static const EdgeInsets screenVerticalPadding = EdgeInsets.symmetric(
    vertical: screenVertical,
  );
  
  /// Padding des cartes
  static const EdgeInsets cardPaddingInsets = EdgeInsets.all(cardPadding);
  
  /// Marge des cartes
  static const EdgeInsets cardMarginInsets = EdgeInsets.all(cardMargin);
  
  /// Padding des boutons
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 12.0,
  );
  
  /// Padding des boutons larges
  static const EdgeInsets buttonLargePadding = EdgeInsets.symmetric(
    horizontal: 32.0,
    vertical: 16.0,
  );
  
  /// Padding des boutons petits
  static const EdgeInsets buttonSmallPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 8.0,
  );
}

/// Rayons de bordure Apple-like
class AppBorderRadius {
  AppBorderRadius._();

  // === RAYONS DE BASE ===
  
  /// Rayon minimal - 4pt
  static const double xs = 4.0;
  
  /// Petit rayon - 8pt
  static const double sm = 8.0;
  
  /// Rayon medium - 12pt
  static const double md = 12.0;
  
  /// Rayon standard - 16pt
  static const double lg = 16.0;
  
  /// Grand rayon - 20pt
  static const double xl = 20.0;
  
  /// Très grand rayon - 24pt
  static const double xxl = 24.0;
  
  /// Rayon circulaire complet
  static const double circular = 1000.0;

  // === BORDER RADIUS PRÉDÉFINIS ===
  
  /// Border radius minimal
  static const BorderRadius radiusXS = BorderRadius.all(Radius.circular(xs));
  
  /// Border radius petit
  static const BorderRadius radiusSM = BorderRadius.all(Radius.circular(sm));
  
  /// Border radius medium
  static const BorderRadius radiusMD = BorderRadius.all(Radius.circular(md));
  
  /// Border radius standard
  static const BorderRadius radiusLG = BorderRadius.all(Radius.circular(lg));
  
  /// Border radius grand
  static const BorderRadius radiusXL = BorderRadius.all(Radius.circular(xl));
  
  /// Border radius très grand
  static const BorderRadius radiusXXL = BorderRadius.all(Radius.circular(xxl));
  
  /// Border radius circulaire
  static const BorderRadius radiusCircular = BorderRadius.all(Radius.circular(circular));
  
  // === RAYONS SPÉCIALISÉS ===
  
  /// Rayon des cartes
  static const BorderRadius cardRadius = radiusLG;
  
  /// Rayon des boutons
  static const BorderRadius buttonRadius = radiusMD;
  
  /// Rayon des boutons ronds
  static const BorderRadius buttonRoundRadius = radiusXL;
  
  /// Rayon des inputs
  static const BorderRadius inputRadius = radiusSM;
  
  /// Rayon des modals et sheets
  static const BorderRadius modalRadius = radiusXL;
  
  /// Rayon du top seulement (pour sheets)
  static const BorderRadius topRadius = BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );
  
  /// Rayon du bottom seulement
  static const BorderRadius bottomRadius = BorderRadius.only(
    bottomLeft: Radius.circular(xl),
    bottomRight: Radius.circular(xl),
  );
}

/// Ombres Apple-like
class AppShadows {
  AppShadows._();

  // === OMBRES DE BASE ===
  
  /// Ombre subtile
  static const BoxShadow subtle = BoxShadow(
    color: Color(0x0A000000),
    offset: Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 0,
  );
  
  /// Ombre légère
  static const BoxShadow light = BoxShadow(
    color: Color(0x14000000),
    offset: Offset(0, 2),
    blurRadius: 8,
    spreadRadius: 0,
  );
  
  /// Ombre medium
  static const BoxShadow medium = BoxShadow(
    color: Color(0x1F000000),
    offset: Offset(0, 4),
    blurRadius: 16,
    spreadRadius: 0,
  );
  
  /// Ombre forte
  static const BoxShadow strong = BoxShadow(
    color: Color(0x29000000),
    offset: Offset(0, 8),
    blurRadius: 24,
    spreadRadius: 0,
  );
  
  /// Ombre très forte
  static const BoxShadow heavy = BoxShadow(
    color: Color(0x33000000),
    offset: Offset(0, 12),
    blurRadius: 32,
    spreadRadius: 0,
  );

  // === LISTES D'OMBRES ===
  
  /// Ombre de carte
  static const List<BoxShadow> card = [light];
  
  /// Ombre de bouton
  static const List<BoxShadow> button = [subtle];
  
  /// Ombre de modal
  static const List<BoxShadow> modal = [strong];
  
  /// Ombre de floating action button
  static const List<BoxShadow> fab = [medium];
  
  /// Ombre d'élévation
  static const List<BoxShadow> elevated = [medium, subtle];
}

/// Dimensions communes
class AppDimensions {
  AppDimensions._();

  // === HAUTEURS STANDARD ===
  
  /// Hauteur d'un bouton standard
  static const double buttonHeight = 48.0;
  
  /// Hauteur d'un bouton petit
  static const double buttonSmallHeight = 36.0;
  
  /// Hauteur d'un bouton large
  static const double buttonLargeHeight = 56.0;
  
  /// Hauteur d'un input
  static const double inputHeight = 44.0;
  
  /// Hauteur d'un élément de liste
  static const double listItemHeight = 56.0;
  
  /// Hauteur de la navigation bar
  static const double navigationBarHeight = 44.0;
  
  /// Hauteur de la tab bar
  static const double tabBarHeight = 83.0;
  
  /// Hauteur de la status bar
  static const double statusBarHeight = 44.0;

  // === LARGEURS STANDARD ===
  
  /// Largeur minimale d'un bouton
  static const double buttonMinWidth = 88.0;
  
  /// Largeur d'un FAB
  static const double fabSize = 56.0;
  
  /// Largeur d'un petit FAB
  static const double fabSmallSize = 40.0;

  // === TAILLES D'ICÔNES ===
  
  /// Icône très petite
  static const double iconXS = 12.0;
  
  /// Icône petite
  static const double iconSM = 16.0;
  
  /// Icône medium
  static const double iconMD = 20.0;
  
  /// Icône standard
  static const double iconLG = 24.0;
  
  /// Icône grande
  static const double iconXL = 32.0;
  
  /// Icône très grande
  static const double iconXXL = 48.0;
  
  /// Icône énorme
  static const double iconHuge = 64.0;

  // === TAILLES SPÉCIALISÉES ===
  
  /// Avatar petit
  static const double avatarSmall = 32.0;
  
  /// Avatar medium
  static const double avatarMedium = 48.0;
  
  /// Avatar large
  static const double avatarLarge = 64.0;
  
  /// Avatar très large
  static const double avatarXLarge = 96.0;
}