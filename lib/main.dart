import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'core/services/navigation_service.dart';
import 'core/models/mood_entry.dart';
import 'core/models/meditation_session.dart';
import 'core/models/user_profile.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Point d'entrée de l'application de santé mentale
void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  setUrlStrategy(PathUrlStrategy());
  
  // Configuration du système overlay pour dark theme
  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemOverlayStyle);
  
  // Initialisation de Hive pour le stockage local
  await Hive.initFlutter();
  
  // Enregistrement des adaptateurs Hive
  Hive.registerAdapter(MoodEntryAdapter());
  Hive.registerAdapter(MeditationSessionAdapter());
  Hive.registerAdapter(MeditationTypeAdapter());
  Hive.registerAdapter(UserProfileAdapter());
  Hive.registerAdapter(UserGoalsAdapter());
  Hive.registerAdapter(NotificationPreferencesAdapter());
  Hive.registerAdapter(DisplayPreferencesAdapter());
  
  // Ouverture des boxes Hive
  await Hive.openBox<MoodEntry>('mood_entries');
  await Hive.openBox<MeditationSession>('meditation_sessions');
  await Hive.openBox<UserProfile>('user_profile');
  
  runApp(
    const ProviderScope(
      child: MentalHealthApp(),
    ),
  );
}

/// Application principale de santé mentale
class MentalHealthApp extends StatelessWidget {
  const MentalHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mind Care - Santé Mentale',
      debugShowCheckedModeBanner: false,
      
      // Configuration du thème
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      
      // Configuration du routing
      routerConfig: AppRouter.router,
      
      // Configuration de la localisation
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('fr', 'FR'),
      ],
      
      // Builder pour la configuration globale
      builder: (context, child) {
        // Configuration des couleurs du système pour l'immersion
        SystemChrome.setSystemUIOverlayStyle(
          AppTheme.systemOverlayStyle.copyWith(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        );
        
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
