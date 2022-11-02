import 'package:flutter/material.dart';
import 'dart:developer';
import 'lang/Fr.dart';

// Créer une classe pour stocker des éléments type de configuration (UI et Data)
abstract class ConfigWidget extends StatelessWidget {
  ConfigWidget({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // Liste des éléments du menu en bas de page
  static List<BottomNavigationBarItem> bottomListItems() {
    List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[];

    // Loop pour créer les boutons du menu
    for (var item in FR.BOTTOM_ITEMS) {
      items.add(BottomNavigationBarItem(
        icon: item['icon'] as Widget,
        label: item['label'] as String,
        // tooltip: item['tooltip'] as String,
      ));
    }
    // print(items);
    inspect(items);
    return items;
  }
}
