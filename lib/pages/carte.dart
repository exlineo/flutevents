import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jrestaujus/services/store-service.dart';
import 'package:jrestaujus/utils/lang/Fr.dart';
import 'package:jrestaujus/utils/Shared.dart';

// Afficher des news tirées de données externes
class CarteWidget extends StatefulWidget {
  const CarteWidget({super.key});
  // Intégration d'un nouvel état dans le composant
  @override
  State<CarteWidget> createState() => _LoadCarteWidget();
}

class _LoadCarteWidget extends State<CarteWidget> {
  // Récupérer la liste des événements
  getEvs() {
    // if (_events.isEmpty) _events = fireService.getEvs();
    // print(_events.isEmpty);
    // print(_events);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const ColoredBox(
        color: Colors.pink,
        child: Padding(
          padding: EdgeInsets.all(15),
          // child: Expanded(
          child: Center(
              child: Text("A la carte",
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
            leading: Container(
              width: 150,
              // height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(fireService.evs[index]['data']['media']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
