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

class _LoadChauffeWidget extends State<ChauffeWidget> with UtilsWidget {
  List<dynamic> _listeEvs = [];

  @override
  initState() {
    _listeEvs = fireService.evs;
  }

  // Récupérer la liste des événements
  filtreEvs(String f) {
    f = f.toLowerCase();
    final l = fireService.evs.where((ev) {
      if (ev['data']['titre'].toLowerCase().indexOf(f) != -1 ||
          ev['data']['description'].toLowerCase().indexOf(f) != -1 ||
          ev['data']['date'].toLowerCase().indexOf(f) != -1) {
        return true;
      }
      return false;
    }).toList();

    setState(() => _listeEvs = l);
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
              child: Text("De quoi ai-je envie ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
        ),
        // ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Filtrer vos favoris'),
            onChanged: filtreEvs),
      ),
      ListView.separated(
        // padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        // itemCount: fireService.evs.length,
        itemCount: _listeEvs.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            visualDensity: const VisualDensity(vertical: 4),
            leading: Container(
              width: 150,
              // height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  // image: NetworkImage(fireService.evs[index]['data']['media']),
                  image: NetworkImage(_listeEvs[index]['data']['media']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_listeEvs[index]['data']['titre']}'),
                Text('le 08/11/22', style: styleMini),
                // _listeEvs[index]['data']['type'] ?
                setType('${_listeEvs[index]['data']['type']}')
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
