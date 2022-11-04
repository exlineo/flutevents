import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutevents/utils/lang/Fr.dart';
import 'package:flutevents/utils/Config.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Afficher des news tirées de données externes
class FaimWidget extends StatefulWidget {
  const FaimWidget({super.key});
  // Intégration d'un nouvel état dans le composant
  @override
  State<FaimWidget> createState() => _LoadNewsWidget();
}

class _LoadNewsWidget extends State<FaimWidget> {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J'
  ];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          visualDensity: const VisualDensity(vertical: 4),
          leading: Image.network(
              'https://theunchained.net/wp-content/uploads/2016/05/converge2-1-678x381.jpg'),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Entry ${entries[index]}'),
              Text('le 08/11/22'),
            ],
          ),
          // trailing: Text('le\n11\n11\n22')
          trailing: const Icon(Icons.favorite_outline),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
