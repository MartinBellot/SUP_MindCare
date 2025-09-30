import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import 'app_dimensions.dart';

/// Thème principal de l'application - Dark Theme Apple-like
class AppTheme {
  AppTheme._();

  /// Thème sombre principal
  static ThemeData get darkTheme {
    return ThemeData(
      // === CONFIGURATION DE BASE ===
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // === COULEURS ===
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryVariant,
        secondary: AppColors.accent,
        secondaryContainer: AppColors.accentSecondary,
        surface: AppColors.backgroundSecondary,
        background: AppColors.background,
        error: AppColors.destructive,
        onPrimary: AppColors.textOnColor,
        onSecondary: AppColors.textOnColor,
        onSurface: AppColors.textPrimary,
        onBackground: AppColors.textPrimary,
        onError: AppColors.textOnColor,
        outline: AppColors.border,
        outlineVariant: AppColors.borderSecondary,
      ),
      
      // === COULEURS CUSTOM ===
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.backgroundSecondary,
      cardColor: AppColors.backgroundSecondary,
      dialogBackgroundColor: AppColors.backgroundElevated,
      
      // === TYPOGRAPHIE ===
      textTheme: const TextTheme(
        displayLarge: AppTypography.largeTitle,
        displayMedium: AppTypography.title1,
        displaySmall: AppTypography.title2,
        headlineLarge: AppTypography.title1,
        headlineMedium: AppTypography.title2,
        headlineSmall: AppTypography.title3,
        titleLarge: AppTypography.title3,
        titleMedium: AppTypography.calloutEmphasized,
        titleSmall: AppTypography.subheadline,
        bodyLarge: AppTypography.body,
        bodyMedium: AppTypography.callout,
        bodySmall: AppTypography.footnote,
        labelLarge: AppTypography.button,
        labelMedium: AppTypography.buttonSmall,
        labelSmall: AppTypography.caption1,
      ).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      
      // === THÈME DES BOUTONS ===
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnColor,
          disabledBackgroundColor: AppColors.surfaceDisabled,
          disabledForegroundColor: AppColors.textTertiary,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.buttonRadius,
          ),
          padding: AppSpacing.buttonPadding,
          minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeight),
          textStyle: AppTypography.button,
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textTertiary,
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.buttonRadius,
          ),
          padding: AppSpacing.buttonPadding,
          minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeight),
          textStyle: AppTypography.button,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textTertiary,
          side: const BorderSide(color: AppColors.border, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: AppBorderRadius.buttonRadius,
          ),
          padding: AppSpacing.buttonPadding,
          minimumSize: const Size(AppDimensions.buttonMinWidth, AppDimensions.buttonHeight),
          textStyle: AppTypography.button,
        ),
      ),
      
      // === THÈME DES CARTES ===
      cardTheme: const CardThemeData(
        color: AppColors.backgroundSecondary,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.background,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.cardRadius,
          side: BorderSide(color: AppColors.borderSecondary, width: 0.5),
        ),
        margin: AppSpacing.cardMarginInsets,
      ),
      
      // === THÈME DE L'APPBAR ===
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.navigationTitle,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      
      // === THÈME DE LA NAVIGATION ===
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundSecondary,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.tabBar,
        unselectedLabelStyle: AppTypography.tabBar,
      ),
      
      // === THÈME DES INPUTS ===
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundControl,
        border: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppBorderRadius.inputRadius,
          borderSide: const BorderSide(color: AppColors.destructive, width: 1),
        ),
        contentPadding: AppSpacing.paddingLG,
        hintStyle: AppTypography.body.copyWith(color: AppColors.textTertiary),
        labelStyle: AppTypography.callout.copyWith(color: AppColors.textSecondary),
      ),
      
      // === THÈME DES SWITCHES ===
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.textOnColor;
          }
          return AppColors.textSecondary;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.backgroundControl;
        }),
      ),
      
      // === THÈME DES SLIDERS ===
      sliderTheme: const SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.backgroundControl,
        thumbColor: AppColors.textOnColor,
        overlayColor: Colors.transparent,
        trackHeight: 4,
      ),
      
      // === THÈME DES DIALOGS ===
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.backgroundElevated,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.modalRadius,
        ),
        titleTextStyle: AppTypography.title3,
        contentTextStyle: AppTypography.body,
      ),
      
      // === THÈME DES BOTTOM SHEETS ===
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.backgroundElevated,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.topRadius,
        ),
        showDragHandle: true,
        dragHandleColor: AppColors.textTertiary,
      ),
      
      // === THÈME DES DIVIDERS ===
      dividerTheme: const DividerThemeData(
        color: AppColors.separator,
        thickness: 0.5,
        space: 1,
      ),
      
      // === THÈME DES ICONS ===
      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
        size: AppDimensions.iconLG,
      ),
      
      primaryIconTheme: const IconThemeData(
        color: AppColors.primary,
        size: AppDimensions.iconLG,
      ),
      
      // === THÈME DES FLOATING ACTION BUTTONS ===
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnColor,
        elevation: 6,
        shape: CircleBorder(),
      ),
      
      // === THÈME DES CHECKBOXES ===
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(AppColors.textOnColor),
        side: const BorderSide(color: AppColors.border, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // === THÈME DES RADIO BUTTONS ===
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.border;
        }),
      ),
      
      // === THÈME DES LIST TILES ===
      listTileTheme: const ListTileThemeData(
        contentPadding: AppSpacing.screenHorizontalPadding,
        tileColor: Colors.transparent,
        selectedTileColor: AppColors.surfaceSelected,
        iconColor: AppColors.textSecondary,
        textColor: AppColors.textPrimary,
        titleTextStyle: AppTypography.body,
        subtitleTextStyle: AppTypography.callout,
      ),
      
      // === THÈME DES TAB BARS ===
      tabBarTheme: const TabBarThemeData(
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: AppTypography.calloutEmphasized,
        unselectedLabelStyle: AppTypography.callout,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        dividerColor: AppColors.separator,
      ),
      
      // === THÈME DES CHIPS ===
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.backgroundControl,
        selectedColor: AppColors.primary,
        disabledColor: AppColors.surfaceDisabled,
        deleteIconColor: AppColors.textSecondary,
        labelStyle: AppTypography.callout,
        secondaryLabelStyle: AppTypography.callout,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.buttonRoundRadius,
        ),
        side: const BorderSide(color: AppColors.border, width: 1),
      ),
    );
  }

    /// Configuration du système overlay pour l'immersion
  static const SystemUiOverlayStyle systemOverlayStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Color(0xFF000000),
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.transparent,
  );
}