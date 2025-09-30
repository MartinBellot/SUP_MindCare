import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/dashboard/dashboard_screen.dart';
import '../../features/mood/mood_tracking_screen.dart';
import '../../features/mood/mood_history_screen.dart';
import '../../features/meditation/meditation_screen.dart';
import '../../features/analytics/analytics_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../shared/widgets/main_navigation.dart';

/// Configuration du routing de l'application
class AppRouter {
  static const String dashboard = '/';
  static const String moodTracking = '/mood';
  static const String moodHistory = '/mood-history';
  static const String meditation = '/meditation';
  static const String analytics = '/analytics';
  static const String profile = '/profile';

  /// Configuration du router
  static final GoRouter router = GoRouter(
    initialLocation: dashboard,
    routes: [
      // Navigation principale avec shell
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigation(child: child);
        },
        routes: [
          // Dashboard - Page d'accueil
          GoRoute(
            path: dashboard,
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          
          // Suivi d'humeur
          GoRoute(
            path: moodTracking,
            name: 'mood-tracking',
            builder: (context, state) => const MoodTrackingScreen(),
          ),
          
          // Historique d'humeur
          GoRoute(
            path: moodHistory,
            name: 'mood-history',
            builder: (context, state) => const MoodHistoryScreen(),
          ),
          
          // Méditation
          GoRoute(
            path: meditation,
            name: 'meditation',
            builder: (context, state) => const MeditationScreen(),
          ),
          
          // Analytics et insights
          GoRoute(
            path: analytics,
            name: 'analytics',
            builder: (context, state) => const AnalyticsScreen(),
          ),
          
          // Profil utilisateur
          GoRoute(
            path: profile,
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page non trouvée',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'L\'URL "${state.uri}" n\'existe pas.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(dashboard),
              child: const Text('Retour à l\'accueil'),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Extension pour faciliter la navigation
extension AppRouterExtension on GoRouter {
  /// Navigue vers le dashboard
  void goToDashboard() => go(AppRouter.dashboard);
  
  /// Navigue vers le suivi d'humeur
  void goToMoodTracking() => go(AppRouter.moodTracking);
  
  /// Navigue vers la méditation
  void goToMeditation() => go(AppRouter.meditation);
  
  /// Navigue vers les analytics
  void goToAnalytics() => go(AppRouter.analytics);
  
  /// Navigue vers le profil
  void goToProfile() => go(AppRouter.profile);
}