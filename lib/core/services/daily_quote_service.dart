import 'dart:math';

/// Service pour gérer les citations quotidiennes anti burn-out
class DailyQuoteService {
  static final DailyQuoteService _instance = DailyQuoteService._internal();
  factory DailyQuoteService() => _instance;
  DailyQuoteService._internal();

  static const List<String> _antiStressQuotes = [
    "Votre bien-être n'est pas négociable. Prenez des pauses et honorez vos limites.",
    "Chaque petit pas vers l'équilibre compte plus qu'un grand saut vers l'épuisement.",
    "Vous êtes plus fort que vous ne le pensez et plus résilient que vous ne l'imaginez.",
    "La productivité sans bien-être n'est qu'une illusion temporaire.",
    "Aujourd'hui, choisissez la bienveillance envers vous-même.",
    "Votre valeur ne se mesure pas à votre productivité, mais à votre humanité.",
    "Respirer profondément est le premier acte de résistance contre le stress.",
    "Il est courageux de ralentir dans un monde qui va trop vite.",
    "Votre santé mentale mérite autant d'attention que votre santé physique.",
    "Parfois, le meilleur travail que vous puissiez faire est de vous reposer.",
    "Vous avez le droit de dire non sans vous justifier.",
    "Chaque moment de calme que vous vous accordez nourrit votre âme.",
    "L'équilibre n'est pas parfait, il est personnel et évolutif.",
    "Votre énergie est précieuse : investissez-la dans ce qui vous fait grandir.",
    "Il n'y a pas de médaille pour celui qui s'épuise le plus.",
    "Aujourd'hui, soyez doux avec vous-même. Vous faites de votre mieux.",
    "La pause n'est pas une perte de temps, c'est un investissement dans votre futur.",
    "Votre bien-être rayonne et inspire ceux qui vous entourent.",
    "Chaque jour est une nouvelle opportunité de prendre soin de vous.",
    "Vous méritez la même compassion que vous offrez aux autres."
  ];

  /// Obtient la citation du jour basée sur la date actuelle
  String getDailyQuote() {
    final today = DateTime.now();
    // Utilise la date comme seed pour avoir la même citation toute la journée
    final dayOfYear = today.difference(DateTime(today.year, 1, 1)).inDays;
    final seed = today.year * 1000 + dayOfYear;
    final random = Random(seed);
    
    final index = random.nextInt(_antiStressQuotes.length);
    return _antiStressQuotes[index];
  }

  /// Obtient une citation aléatoire (pour des usages autres que la citation du jour)
  String getRandomQuote() {
    final random = Random();
    final index = random.nextInt(_antiStressQuotes.length);
    return _antiStressQuotes[index];
  }

  /// Obtient toutes les citations disponibles
  List<String> getAllQuotes() {
    return List.unmodifiable(_antiStressQuotes);
  }

  /// Nombre total de citations disponibles
  int get quotesCount => _antiStressQuotes.length;
}