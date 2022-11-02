import 'package:flutter/material.dart';

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
        return Container(
          height: 100,
          // color: Colors.pink[colorCodes[index]],
          child: Center(child: Text('Entry ${entries[index]}')),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
