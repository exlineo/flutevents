import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutevents/utils/lang/Fr.dart';
import 'package:flutevents/utils/Config.dart';

import '../services/store-service.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

// Afficher des news tirées de données externes
class VitaminesWidget extends StatefulWidget {
  const VitaminesWidget({super.key});

  // Intégration d'un nouvel état dans le composant
  @override
  State<VitaminesWidget> createState() => _LoadNewsWidget();
}

class _LoadNewsWidget extends State<VitaminesWidget> {
  List<Map<String, dynamic>> _events = [];

  final List<int> colorCodes = <int>[600, 500, 100];
  // Récupérer la liste des événements
  getEvs() {
    if (_events.isEmpty) _events = fireService.getEvs();
    print(_events.isEmpty);
    print(_events);
  }

  @override
  Widget build(BuildContext context) {
    // Lancer la récupération de la liste des événements
    getEvs();
    return ListView.separated(
      // padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: _events.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          visualDensity: const VisualDensity(vertical: 4),
          leading: Image.network(
              'https://theunchained.net/wp-content/uploads/2016/05/converge2-1-678x381.jpg'),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${_events[index]['data']['titre']}'),
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
