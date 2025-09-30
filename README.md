# 🧠 Mind Care - Application de Santé Mentale

<div align="center">

![Mind Care Logo](https://img.shields.io/badge/Mind%20Care-Santé%20Mentale-4CAF50?style=for-the-badge&logo=flutter)

[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=flat&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-iOS%20|%20Android%20|%20Web-lightgrey?style=flat)](https://flutter.dev/multi-platform)

**Une application mobile moderne de gestion de santé mentale pour prévenir les risques de burnout**

*Design ultra moderne façon Apple avec dark theme immersif*

[🚀 Démo en direct](#démo) • [📱 Captures d'écran](#captures-décran) • [🔧 Installation](#installation) • [📖 Documentation](#documentation)

</div>

---

## 📋 Table des matières

- [🎯 Vue d'ensemble](#-vue-densemble)
- [✨ Fonctionnalités](#-fonctionnalités)
- [🏗️ Architecture](#️-architecture)
- [🎨 Design System](#-design-system)
- [📱 Captures d'écran](#-captures-décran)
- [🔧 Installation](#-installation)
- [🚀 Démarrage rapide](#-démarrage-rapide)
- [📖 Documentation technique](#-documentation-technique)
- [🛠️ Technologies utilisées](#️-technologies-utilisées)
- [📊 Structure du projet](#-structure-du-projet)
- [🔒 Sécurité et confidentialité](#-sécurité-et-confidentialité)
- [🌐 Ressources externes](#-ressources-externes)
- [🤝 Contribution](#-contribution)
- [📄 Licence](#-licence)

---

## 🎯 Vue d'ensemble

**Mind Care** est une application mobile révolutionnaire dédiée à la santé mentale et à la prévention du burnout. Conçue avec une approche holistique du bien-être, elle combine un design Apple-like ultra moderne avec des fonctionnalités scientifiquement validées pour accompagner les utilisateurs dans leur parcours de santé mentale.

### 🌟 Vision

Démocratiser l'accès aux outils de santé mentale en proposant une expérience utilisateur exceptionnelle, intuitive et personnalisée, inspirée des meilleurs standards de design d'Apple.

### 🎯 Mission

- **Prévenir** les risques de burnout grâce à un suivi personnalisé
- **Accompagner** les utilisateurs avec des outils validés scientifiquement
- **Connecter** avec des ressources professionnelles et d'aide
- **Sensibiliser** à l'importance de la santé mentale

---

## ✨ Fonctionnalités

### 🏠 Dashboard Intelligent
- **Météo mentale** avec visualisation intuitive de l'état émotionnel
- **Statistiques en temps réel** avec anneaux de progression animés
- **Actions rapides** pour un accès immédiat aux outils essentiels
- **Insights IA** personnalisés basés sur les données utilisateur
- **Cartes interactives** avec animations fluides et micro-interactions

### 💚 Suivi d'humeur avancé
- **Enregistrement quotidien** avec interface Apple-like
- **Échelle émotionnelle** intuitive (5 niveaux)
- **Visualisation graphique** des tendances avec Flutter Charts
- **Historique détaillé** avec filtres et analyses
- **Corrélations intelligentes** entre humeur et activités

### 🧘 Méditation et relaxation
- **Exercices de respiration** guidés avec animations visuelles
- **Méditations guidées** pour différents objectifs
- **Techniques anti-stress** validées scientifiquement
- **Programmes personnalisés** adaptés au niveau de l'utilisateur
- **Suivi des séances** avec statistiques de progression

### 📊 Analytics et insights
- **Graphiques interactifs** avec FL Chart
- **Tendances personnalisées** basées sur l'IA
- **Rapports de progrès** détaillés
- **Recommandations intelligentes** pour améliorer le bien-être
- **Visualisations modernes** avec design Apple-like

### 👤 Profil et paramètres
- **Avatar personnalisé** avec système de badges
- **Objectifs personnels** avec suivi de progression
- **Préférences avancées** pour personnaliser l'expérience
- **Export de données** au format JSON/CSV
- **Gestion de la confidentialité** avec contrôle total

### 🆘 Ressources d'aide
- **Numéros d'urgence** facilement accessibles
- **Lignes d'écoute** nationales et locales
- **Ressources en ligne** validées et actualisées
- **Annuaires de professionnels** avec liens directs
- **Lancement d'appels** et ouverture de sites en un clic

---

## 🏗️ Architecture

Mind Care suit une architecture **Clean Architecture** avec une séparation claire des responsabilités :

```
lib/
├── core/                    # Couche infrastructure
│   ├── models/             # Modèles de données Hive
│   ├── services/           # Services (navigation, stockage)
│   └── theme/              # Système de design
├── features/               # Fonctionnalités métier
│   ├── dashboard/          # Écran d'accueil
│   ├── mood/              # Suivi d'humeur
│   ├── meditation/        # Méditation et relaxation
│   ├── analytics/         # Analytics et insights
│   ├── profile/           # Profil utilisateur
│   └── resources/         # Ressources d'aide
└── shared/                # Composants partagés
    └── widgets/           # Widgets réutilisables
```

### 🔧 Principes architecturaux

- **Séparation des responsabilités** : Chaque couche a un rôle défini
- **Injection de dépendances** avec Riverpod
- **Gestion d'état réactive** pour une UX fluide
- **Navigation déclarative** avec GoRouter
- **Stockage local sécurisé** avec Hive

---

## 🎨 Design System

### 🌙 Dark Theme Apple-like

Mind Care adopte un design system inspiré d'Apple avec une approche dark theme immersive :

#### 🎨 Palette de couleurs
```dart
// Couleurs primaires
Primary Blue: #007AFF      // Bleu système Apple
Accent Green: #30D158      // Vert bien-être
Warning Orange: #FF9F0A    // Orange alertes
Destructive Red: #FF453A   // Rouge urgences

// Backgrounds dark
Background: #000000        // Noir profond
Secondary: #1C1C1E        // Gris foncé Apple
Tertiary: #2C2C2E         // Gris moyen
```

#### ✍️ Typographie
```dart
// Hiérarchie typographique Apple
Large Title: Inter, 34pt, Bold
Title 1: Inter, 28pt, Bold
Title 2: Inter, 22pt, Bold
Title 3: Inter, 20pt, Semibold
Headline: Inter, 17pt, Semibold
Body: Inter, 17pt, Regular
Caption: Inter, 12pt, Regular
```

#### 📐 Spacing System
```dart
// Grille de 4pt pour la cohérence
XS: 4pt    SM: 8pt     MD: 12pt
LG: 16pt   XL: 20pt    XXL: 24pt
XXXL: 32pt HUGE: 40pt  MASSIVE: 48pt
```

### 🎭 Animations et micro-interactions

- **Flutter Animate** pour des animations fluides
- **Transitions personnalisées** entre écrans
- **Micro-interactions** sur tous les éléments tactiles
- **Feedback haptique** pour une expérience premium
- **Glassmorphism** et effets de profondeur

---

## 📱 Captures d'écran

### 🏠 Dashboard
<details>
<summary>Voir les captures du dashboard</summary>

*À venir : Captures d'écran du dashboard avec météo mentale, statistiques et actions rapides*

</details>

### 💚 Suivi d'humeur
<details>
<summary>Voir les captures du suivi d'humeur</summary>

*À venir : Captures d'écran de l'enregistrement d'humeur et visualisations*

</details>

### 🧘 Méditation
<details>
<summary>Voir les captures de méditation</summary>

*À venir : Captures d'écran des exercices de respiration et méditations guidées*

</details>

### 📊 Analytics
<details>
<summary>Voir les captures d'analytics</summary>

*À venir : Captures d'écran des graphiques et insights*

</details>

---

## 🔧 Installation

### ⚡ Prérequis

- **Flutter SDK** : 3.10.0 ou supérieur
- **Dart SDK** : 3.0.0 ou supérieur
- **IDE** : VS Code ou Android Studio
- **Git** pour le clonage du repository

### 📥 Clonage du projet

```bash
# Cloner le repository
git clone https://github.com/MartinBellot/SUP_MindCare.git

# Naviguer dans le dossier
cd SUP_MindCare

# Installer les dépendances
flutter pub get

# Générer les adaptateurs Hive
flutter packages pub run build_runner build
```

### 🔧 Configuration

1. **Vérification de l'environnement**
```bash
flutter doctor
```

2. **Configuration des signatures iOS** (pour iOS)
```bash
cd ios
pod install
```

3. **Configuration Android** (optionnel)
- Vérifier le fichier `android/app/build.gradle`
- S'assurer que les permissions sont correctes

---

## 🚀 Démarrage rapide

### 💻 Développement

```bash
# Lancer en mode debug
flutter run

# Lancer sur un device specific
flutter run -d chrome          # Web
flutter run -d ios             # iOS Simulator
flutter run -d android         # Android Emulator

# Hot reload activé automatiquement
# Appuyez sur 'r' pour recharger
# Appuyez sur 'R' pour redémarrer
```

### 🌐 Web
```bash
# Lancer sur le web avec serveur local
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080

# Build pour production web
flutter build web --release
```

### 📱 Mobile
```bash
# Build APK Android
flutter build apk --release

# Build iOS (sur macOS uniquement)
flutter build ios --release
```

---

## 📖 Documentation technique

### 🗄️ Gestion des données

Mind Care utilise **Hive** pour le stockage local sécurisé :

```dart
// Modèles de données
MoodEntry       // Entrées d'humeur quotidiennes
MeditationSession // Sessions de méditation
UserProfile     // Profil et préférences utilisateur
```

### 🧭 Navigation

Navigation déclarative avec **GoRouter** :

```dart
// Routes principales
/                    // Dashboard
/mood               // Suivi d'humeur
/meditation         // Méditation
/analytics          // Analytics
/profile            // Profil
/resources          // Ressources d'aide
```

### 🎨 Thème et design

```dart
// Thème principal
AppTheme.darkTheme  // Thème dark Apple-like
AppColors.*         // Palette de couleurs
AppTypography.*     // Système typographique
AppSpacing.*        // Système d'espacement
```

### 📊 Gestion d'état

**Flutter Riverpod** pour une gestion d'état réactive :

```dart
// Providers principaux
moodProvider        // État du suivi d'humeur
profileProvider     // État du profil utilisateur
analyticsProvider   // État des analytics
```

---

## 🛠️ Technologies utilisées

### 🎯 Core Framework
- **Flutter** 3.10+ - Framework UI cross-platform
- **Dart** 3.0+ - Langage de programmation

### 📦 Dépendances principales

#### 🎨 UI & Design
```yaml
flutter_svg: ^2.0.10+1           # Icônes et illustrations SVG
cupertino_icons: ^1.0.8          # Icônes iOS
flutter_animate: ^4.5.0          # Animations fluides
```

#### 🔄 État et navigation
```yaml
flutter_riverpod: ^2.5.1         # Gestion d'état réactive
go_router: ^14.2.7               # Navigation déclarative
```

#### 💾 Stockage et données
```yaml
hive: ^2.2.3                     # Base de données locale
hive_flutter: ^1.1.0             # Intégration Flutter
shared_preferences: ^2.2.3       # Préférences simples
```

#### 📊 Visualisations
```yaml
fl_chart: ^0.69.0                # Graphiques et charts
```

#### 🌐 Intégrations externes
```yaml
url_launcher: ^6.3.0             # Ouverture de liens
dio: ^5.7.0                      # HTTP client
```

#### 📅 Utilitaires
```yaml
intl: ^0.20.2                    # Internationalisation
flutter_localizations: SDK       # Localisation Flutter
```

### 🏗️ Architecture et patterns

- **Clean Architecture** - Séparation des responsabilités
- **Provider Pattern** - Injection de dépendances
- **Repository Pattern** - Abstraction des données
- **MVVM** - Model-View-ViewModel

---

## 📊 Structure du projet

```
SUP_MindCare/
├── 📁 android/                 # Configuration Android
├── 📁 ios/                     # Configuration iOS
├── 📁 lib/                     # Code source Dart
│   ├── 📁 core/               # Infrastructure
│   │   ├── 📁 models/         # Modèles de données Hive
│   │   │   ├── mood_entry.dart
│   │   │   ├── meditation_session.dart
│   │   │   └── user_profile.dart
│   │   ├── 📁 services/       # Services applicatifs
│   │   │   └── navigation_service.dart
│   │   └── 📁 theme/          # Système de design
│   │       ├── app_colors.dart
│   │       ├── app_typography.dart
│   │       ├── app_dimensions.dart
│   │       └── app_theme.dart
│   ├── 📁 features/           # Fonctionnalités métier
│   │   ├── 📁 dashboard/      # Écran d'accueil
│   │   │   └── dashboard_screen.dart
│   │   ├── 📁 mood/           # Suivi d'humeur
│   │   │   ├── mood_tracking_screen.dart
│   │   │   └── mood_history_screen.dart
│   │   ├── 📁 meditation/     # Méditation
│   │   │   └── meditation_screen.dart
│   │   ├── 📁 analytics/      # Analytics
│   │   │   └── analytics_screen.dart
│   │   ├── 📁 profile/        # Profil utilisateur
│   │   │   └── profile_screen.dart
│   │   └── 📁 resources/      # Ressources d'aide
│   │       └── screens/
│   │           └── resources_screen.dart
│   ├── 📁 shared/             # Composants partagés
│   │   └── 📁 widgets/        # Widgets réutilisables
│   │       ├── dashboard_card.dart
│   │       ├── mental_weather_card.dart
│   │       ├── animated_wellness_ring.dart
│   │       ├── modern_stats_card.dart
│   │       ├── quick_actions.dart
│   │       └── main_navigation.dart
│   └── main.dart              # Point d'entrée
├── 📁 test/                   # Tests unitaires
├── 📁 web/                    # Configuration Web
├── 📄 pubspec.yaml           # Dépendances
├── 📄 analysis_options.yaml  # Configuration Dart
└── 📄 README.md              # Documentation
```

---

## 🔒 Sécurité et confidentialité

### 🛡️ Protection des données

- **Stockage local uniquement** - Aucune donnée envoyée sur des serveurs externes
- **Chiffrement Hive** - Toutes les données sensibles sont chiffrées
- **Pas de tracking** - Aucun suivi des utilisateurs
- **RGPD compliant** - Respect total de la vie privée

### 🔐 Mesures de sécurité

- **Validation des entrées** - Toutes les données sont validées
- **Gestion sécurisée des URLs** - url_launcher avec validation
- **Permissions minimales** - Seules les permissions nécessaires
- **Code obfusqué** - Protection du code en production

### 📋 Permissions requises

#### Android
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CALL_PHONE" />
```

#### iOS
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

---

## 🌐 Ressources externes

### 🆘 Numéros d'urgence intégrés

- **15** - SAMU (Urgences médicales)
- **3114** - Numéro national de prévention du suicide
- **09 72 39 40 50** - SOS Amitié
- **01 45 39 40 00** - Suicide Écoute

### 🔗 Sites partenaires

- **Psycom** - Information santé mentale
- **Santé.fr** - Service public de santé
- **Doctolib** - Prise de rendez-vous
- **MonPsy** - Dispositif de remboursement

### 📚 Ressources scientifiques

Les techniques et exercices intégrés sont basés sur :
- **Thérapies cognitivo-comportementales (TCC)**
- **Mindfulness et méditation de pleine conscience**
- **Techniques de gestion du stress validées**
- **Recherches en psychologie positive**

---

## 🤝 Contribution

### 🎯 Comment contribuer

1. **Fork** le projet
2. **Créer une branche** pour votre fonctionnalité
   ```bash
   git checkout -b feature/nouvelle-fonctionnalite
   ```
3. **Commiter** vos modifications
   ```bash
   git commit -m "Ajout d'une nouvelle fonctionnalité"
   ```
4. **Push** vers la branche
   ```bash
   git push origin feature/nouvelle-fonctionnalite
   ```
5. **Ouvrir une Pull Request**

### 🧪 Tests et qualité

```bash
# Lancer les tests
flutter test

# Analyser le code
flutter analyze

# Formater le code
flutter format lib/

# Vérifier la couverture
flutter test --coverage
```

### 📝 Standards de code

- **Dart Effective Style Guide**
- **Commentaires en français**
- **Tests unitaires obligatoires**
- **Documentation des APIs publiques**

---

## 📄 Licence

Ce projet est sous licence **MIT** - voir le fichier [LICENSE](LICENSE) pour les détails.

```
MIT License

Copyright (c) 2025 Martin Bellot

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 📞 Contact et support

### 👨‍💻 Développeur

**Martin Bellot**
- 📧 Email : [martin.bellot@example.com](mailto:martin.bellot@example.com)
- 🐙 GitHub : [@MartinBellot](https://github.com/MartinBellot)
- 💼 LinkedIn : [Martin Bellot](https://linkedin.com/in/martin-bellot)

### 🐛 Signaler un bug

Utilisez les [Issues GitHub](https://github.com/MartinBellot/SUP_MindCare/issues) pour :
- 🐛 Signaler des bugs
- 💡 Proposer des améliorations
- ❓ Poser des questions
- 📖 Demander de la documentation

### 💬 Communauté

- 📱 Discussions GitHub pour les questions générales
- 🔧 Issues pour les problèmes techniques
- 📧 Email pour les questions confidentielles

---

<div align="center">

### 🙏 Remerciements

Mind Care est développé avec passion pour contribuer au bien-être mental de tous.

**Ensemble, prenons soin de notre santé mentale** 💚

---

*Dernière mise à jour : 30 septembre 2025*

[![Built with Flutter](https://img.shields.io/badge/Built%20with-Flutter-blue.svg?style=flat&logo=flutter)](https://flutter.dev)
[![Made with ❤️](https://img.shields.io/badge/Made%20with-❤️-red.svg)](https://github.com/MartinBellot)

</div>
