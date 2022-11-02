import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutevents/utils/lang/Fr.dart';
import 'package:flutevents/utils/Config.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Afficher des news tirées de données externes
class VitaminesWidget extends StatefulWidget {
  const VitaminesWidget({super.key});
  // Intégration d'un nouvel état dans le composant
  @override
  State<VitaminesWidget> createState() => _LoadNewsWidget();
}

class _LoadNewsWidget extends State<VitaminesWidget> {
  final List<String> entries = <String>['A', 'B', 'C', 'D', 'E', 'F', 'G'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 100,
          // color: Colors.pink[colorCodes[index]],
          child: Row(mainAxisSize: MainAxisSize.max, children: [
            Image.network(
                'https://theunchained.net/wp-content/uploads/2016/05/converge2-1-678x381.jpg'),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('Entry ${entries[index]}')),
            const Spacer(),
            const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text('Le\n08\n11\n22', textAlign: TextAlign.center)),
          ]),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
