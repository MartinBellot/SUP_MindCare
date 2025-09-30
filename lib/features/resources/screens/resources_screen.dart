import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_dimensions.dart';

/// Écran des ressources avec numéros utiles et liens
class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Ressources',
          style: AppTypography.title2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Urgences
            _buildSectionHeader(
              'Urgences',
              'En cas de crise immédiate',
              Icons.emergency,
              AppColors.accent,
            ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.2),
            
            const SizedBox(height: AppSpacing.md),
            
            _buildEmergencyCard().animate().fadeIn(duration: 400.ms, delay: 100.ms),
            
            const SizedBox(height: AppSpacing.xxxl),
            
            // Section Écoute et Soutien
            _buildSectionHeader(
              'Écoute et Soutien',
              'Lignes d\'aide et d\'écoute',
              Icons.headset_mic,
              AppColors.primary,
            ).animate().fadeIn(duration: 300.ms, delay: 200.ms).slideX(begin: -0.2),
            
            const SizedBox(height: AppSpacing.md),
            
            ..._buildSupportCards().animate(interval: 100.ms).fadeIn(duration: 400.ms),
            
            const SizedBox(height: AppSpacing.xxxl),
            
            // Section Ressources en Ligne
            _buildSectionHeader(
              'Ressources en Ligne',
              'Sites et applications utiles',
              Icons.language,
              AppColors.accentSecondary,
            ).animate().fadeIn(duration: 300.ms, delay: 400.ms).slideX(begin: -0.2),
            
            const SizedBox(height: AppSpacing.md),
            
            ..._buildOnlineResourceCards().animate(interval: 100.ms).fadeIn(duration: 400.ms),
            
            const SizedBox(height: AppSpacing.xxxl),
            
            // Section Professionnels
            _buildSectionHeader(
              'Trouver un Professionnel',
              'Annuaires et plateformes',
              Icons.medical_services,
              AppColors.warning,
            ).animate().fadeIn(duration: 300.ms, delay: 600.ms).slideX(begin: -0.2),
            
            const SizedBox(height: AppSpacing.md),
            
            ..._buildProfessionalCards().animate(interval: 100.ms).fadeIn(duration: 400.ms),
            
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.title3.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: AppTypography.caption1.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.emergency,
              color: AppColors.accent,
              size: 30,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Numéro d\'urgence',
            style: AppTypography.subheadline.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'En cas de danger immédiat pour vous ou autrui',
            style: AppTypography.caption1.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          _buildPhoneButton('15', 'SAMU', () => _makePhoneCall('15')),
          const SizedBox(height: AppSpacing.sm),
          _buildPhoneButton('3114', 'Numéro national de prévention du suicide', () => _makePhoneCall('3114')),
        ],
      ),
    );
  }

  List<Widget> _buildSupportCards() {
    final supportResources = [
      {
        'title': 'SOS Amitié',
        'phone': '09 72 39 40 50',
        'description': 'Écoute anonyme 24h/24',
        'website': 'https://www.sos-amitie.com',
      },
      {
        'title': 'Suicide Écoute',
        'phone': '01 45 39 40 00',
        'description': '24h/24, 7j/7',
        'website': 'https://www.suicide-ecoute.fr',
      },
      {
        'title': 'SOS Dépression',
        'phone': '08 92 70 12 38',
        'description': 'Écoute et orientation',
        'website': 'https://sos.depression.free.fr',
      },
      {
        'title': 'Croix-Rouge Écoute',
        'phone': '0 800 858 858',
        'description': 'Soutien psychologique gratuit',
        'website': 'https://www.croix-rouge.fr',
      },
    ];

    return supportResources.map((resource) => Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: _buildResourceCard(
        title: resource['title']!,
        phone: resource['phone']!,
        description: resource['description']!,
        website: resource['website']!,
        color: AppColors.primary,
      ),
    )).toList();
  }

  List<Widget> _buildOnlineResourceCards() {
    final onlineResources = [
      {
        'title': 'Psycom',
        'description': 'Information et ressources en santé mentale',
        'website': 'https://www.psycom.org',
      },
      {
        'title': 'Santé.fr',
        'description': 'Service public d\'information en santé',
        'website': 'https://www.sante.fr',
      },
      {
        'title': 'France Dépression',
        'description': 'Association d\'aide aux personnes dépressives',
        'website': 'https://www.france-depression.org',
      },
      {
        'title': 'Unafam',
        'description': 'Soutien aux familles de malades psychiques',
        'website': 'https://www.unafam.org',
      },
      {
        'title': 'Nightline France',
        'description': 'Écoute nocturne par et pour les étudiants',
        'website': 'https://www.nightline.fr',
      },
    ];

    return onlineResources.map((resource) => Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: _buildWebsiteCard(
        title: resource['title']!,
        description: resource['description']!,
        website: resource['website']!,
        color: AppColors.accentSecondary,
      ),
    )).toList();
  }

  List<Widget> _buildProfessionalCards() {
    final professionalResources = [
      {
        'title': 'Doctolib',
        'description': 'Prendre rendez-vous avec un psychologue',
        'website': 'https://www.doctolib.fr',
      },
      {
        'title': 'MonPsy',
        'description': 'Dispositif de remboursement des séances',
        'website': 'https://monpsy.sante.gouv.fr',
      },
      {
        'title': 'Ordre des Psychologues',
        'description': 'Annuaire officiel des psychologues',
        'website': 'https://www.ordre-psychologues.fr',
      },
      {
        'title': 'Maisons des Adolescents',
        'description': 'Accueil et écoute pour les 11-25 ans',
        'website': 'https://www.anmda.fr',
      },
    ];

    return professionalResources.map((resource) => Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: _buildWebsiteCard(
        title: resource['title']!,
        description: resource['description']!,
        website: resource['website']!,
        color: AppColors.warning,
      ),
    )).toList();
  }

  Widget _buildResourceCard({
    required String title,
    required String phone,
    required String description,
    required String website,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.support_agent,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.subheadline.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      description,
                      style: AppTypography.caption1.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.phone,
                  label: phone,
                  onTap: () => _makePhoneCall(phone),
                  isPrimary: true,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.language,
                  label: 'Site web',
                  onTap: () => _launchUrl(website),
                  isPrimary: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWebsiteCard({
    required String title,
    required String description,
    required String website,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.language,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.subheadline.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      description,
                      style: AppTypography.caption1.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _buildActionButton(
            icon: Icons.open_in_new,
            label: 'Visiter le site',
            onTap: () => _launchUrl(website),
            isPrimary: true,
            fullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneButton(String number, String label, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.accent, AppColors.accent.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: AppColors.textOnColor,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.sm),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      number,
                      style: AppTypography.subheadline.copyWith(
                        color: AppColors.textOnColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      label,
                      style: AppTypography.caption2.copyWith(
                        color: AppColors.textOnColor.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isPrimary,
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      height: 44,
      decoration: BoxDecoration(
        gradient: isPrimary
            ? LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isPrimary ? null : AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: isPrimary ? null : Border.all(
          color: AppColors.border,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isPrimary ? AppColors.textOnColor : AppColors.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  label,
                  style: AppTypography.caption1.copyWith(
                    color: isPrimary ? AppColors.textOnColor : AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(' ', '');
    final uri = Uri.parse('tel:$cleanNumber');
    
    try {
      await launchUrl(uri);
      HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Impossible d\'ouvrir l\'application téléphone: $e');
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      HapticFeedback.lightImpact();
    } catch (e) {
      debugPrint('Impossible d\'ouvrir l\'URL: $e');
    }
  }
}