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
  // Créer une liste de bouton de menu en bas de page
  static List<Map<String, Object>> BOTTOM_ITEMS = [
    {
      "icon": const Icon(Icons.favorite),
      "label": "Mes vitamines",
      "tooltip": "C'est pour bientôt"
    },
    {
      "icon": const Icon(Icons.delivery_dining),
      "label": "A la carte",
      "tooltip": "Les autres évènements"
    },
    {
      "icon": const Icon(Icons.menu_book),
      "label": "J'ai faim",
      "tooltip": "Ils sont tous là"
    },
    {
      "icon": const Icon(Icons.menu),
      "label": "Miam",
      "tooltip": "C'est pour bientôt"
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
