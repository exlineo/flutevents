import 'package:flutter/material.dart';

class BottomBouton {
  const BottomBouton(this.icon, this.label);
  final Widget icon;
  final String label;
}

abstract class FR {
  // static late FR _instance;
  // factory FR() => _instance ??= new FR._();
  // FR._();
  // Ces variables peuvent être appelées dans une autre classe
  static const String APP_ACCUEIL = 'Au jus';
  static const String APP_INFO =
      "Votre application pour ne plus rater un événement";
  static const String APP = "J'RESTE AU JUS";
  static const Map<String, String> trad = {};
  static const Map<String, Map<String, String>> PAGES = {
    "vitamines": {
      "titre": "Mes vitamines",
      "infos": "Les événéments que j'ai choisis"
    },
    "chauffe": {"titre": "Ca chauffe", "infos": "Evénements à venir"},
    "carte": {"titre": "A la carte", "infos": "Tous les événements à trier"},
    "fournisseurs": {
      "titre": "Fournisseurs",
      "infos": "Ils fournissent vos événements"
    },
  };
  // Créer une liste de bouton de menu en bas de page
  static List<Map<String, Object>> BOTTOM_ITEMS = [
    {
      "icon": const Icon(Icons.favorite),
      "label": PAGES['vitamines']!['titre'] as String,
      "tooltip": PAGES['vitamines']!['infos'] as String,
    },
    {
      "icon": const Icon(Icons.delivery_dining),
      "label": PAGES['chauffe']!['titre'] as String,
      "tooltip": PAGES['chauffe']!['titre'] as String,
    },
    {
      "icon": const Icon(Icons.menu_book),
      "label": PAGES['carte']!['titre'] as String,
      "tooltip": PAGES['carte']!['infos'] as String,
    },
    {
      "icon": const Icon(Icons.menu),
      "label": PAGES['fournisseurs']!['titre'] as String,
      "tooltip": PAGES['fournisseurs']!['infos'] as String,
    },
    // {
    //   "icon": const Icon(Icons.info),
    //   "label": "Quid ?",
    //   "tooltip": "Faire mes choix"
    // }
  ];
  // Donner accès à une variable privée dans la classe avec un getter
  static bool _debug = false;
  get debug => _debug;
}
