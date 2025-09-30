import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/theme.dart';

/// Navigation principale de l'application avec bottom navigation bar
class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const _BottomNavigationBar(),
    );
  }
}

/// Bottom navigation bar personnalisée Apple-like
class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();
    
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
        border: Border(
          top: BorderSide(
            color: AppColors.borderSecondary,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: AppDimensions.tabBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationItem(
                icon: Icons.dashboard_rounded,
                label: 'Accueil',
                isSelected: currentLocation == '/',
                onTap: () => context.go('/'),
              ),
              _NavigationItem(
                icon: Icons.favorite_rounded,
                label: 'Humeur',
                isSelected: currentLocation == '/mood',
                onTap: () => context.go('/mood'),
              ),
              _NavigationItem(
                icon: Icons.self_improvement_rounded,
                label: 'Méditation',
                isSelected: currentLocation == '/meditation',
                onTap: () => context.go('/meditation'),
              ),
              _NavigationItem(
                icon: Icons.support_agent_rounded,
                label: 'Ressources',
                isSelected: currentLocation == '/resources',
                onTap: () => context.go('/resources'),
              ),
              _NavigationItem(
                icon: Icons.person_rounded,
                label: 'Profil',
                isSelected: currentLocation == '/profile',
                onTap: () => context.go('/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Item individuel de navigation
class _NavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorderRadius.radiusSM,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: AppSpacing.paddingXS,
              child: Icon(
                icon,
                size: AppDimensions.iconLG,
                color: isSelected 
                  ? AppColors.primary 
                  : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.tabBar.copyWith(
                color: isSelected 
                  ? AppColors.primary 
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
  }
}