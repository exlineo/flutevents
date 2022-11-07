import 'dart:ui';
import 'package:jrestaujus/services/store-service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import 'lang/Fr.dart';

// liste des icones disponibles : https://fontawesomeicons.com/flutter/icons
// Créer une classe pour stocker des éléments type de configuration (UI et Data)
abstract class SharedWidget extends StatelessWidget {
  SharedWidget({super.key});

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
    return items;
  }
}

mixin UtilsWidget {
  // Transformer une date à partir d'un timestamp
  setDate(time) {
    // print('Time to date : ${time.toString()}');
    // var d = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    // return DateFormat('dd/MM/yyyy').format(d);
  }

  TextStyle styleEm =
      const TextStyle(fontSize: 12, fontStyle: FontStyle.italic);
  TextStyle styleTitre =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle styleEntete =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  Widget logoNul = Center(
      child: Column(
    children: [
      Image.asset('assets/images/juice.png'),
      const Text(":/ C'est vide ici",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
    ],
  ));
}
