import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jrestaujus/services/store-service.dart';
import 'package:jrestaujus/utils/lang/Fr.dart';
import 'package:jrestaujus/utils/Shared.dart';

// Afficher des news tirées de données externes
class ChauffeWidget extends StatefulWidget {
  const ChauffeWidget({super.key});
  // Intégration d'un nouvel état dans le composant
  @override
  State<ChauffeWidget> createState() => _LoadChauffeWidget();
}

class _LoadChauffeWidget extends State<ChauffeWidget> {
  // Récupérer la liste des événements
  getEvs() {
    // if (_events.isEmpty) _events = fireService.getEvs();
    // print(_events.isEmpty);
    // print(_events);
  }

  @override
  Widget build(BuildContext context) {
    // Lancer la récupération de la liste des événements
    // getEvs();
    return Column(children: [
      const ColoredBox(
        color: Colors.pink,
        child: Padding(
          padding: EdgeInsets.all(15),
          // child: Expanded(
          child: Center(
              child: Text("De quoi ai-je envie ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
        ),
        // ),
      ),
      ListView.separated(
        // padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        itemCount: fireService.evs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            visualDensity: const VisualDensity(vertical: 4),
            leading: Image.network(fireService.evs[index]['data']['media']),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${fireService.evs[index]['data']['titre']}'),
                Text('le 08/11/22'),
              ],
            ),
            // trailing: Text('le\n11\n11\n22')
            trailing: const Icon(Icons.favorite_outline),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      )
    ]);
  }
}
