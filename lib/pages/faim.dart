import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jrestaujus/services/store-service.dart';
import 'package:jrestaujus/utils/lang/Fr.dart';
import 'package:jrestaujus/utils/Shared.dart';

// Afficher des news tirées de données externes
class FaimWidget extends StatefulWidget {
  const FaimWidget({super.key});
  // Intégration d'un nouvel état dans le composant
  @override
  State<FaimWidget> createState() => _LoadNewsWidget();
}

class _LoadNewsWidget extends State<FaimWidget> with UtilsWidget {
  /** Initialiser une valeur dynamique */
  @override
  void initState() {
    super.initState();

    // fireService.getSyncEvs().then((ev) => {
    //       setState(() {
    //         // _evs = ev;
    //       })
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fireService.getFutureEvs(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Remplace le contenu par un loader en attendant les données
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        // Si des données sont reçues, le contenu est
        if (snapshot.hasData) {
          return Column(children: [
            const ColoredBox(
              color: Colors.pink,
              child: Padding(
                padding: EdgeInsets.all(15),
                // child: Expanded(
                child: Center(
                    child: Text("Montre moi des trucs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ),
              // ),
            ),
            Expanded(
                child: ListView.builder(
                    // padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemCount: fireService.evs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                              fireService.evs[index]['data']['media']),
                          ListTile(
                              // visualDensity: const VisualDensity(vertical: 4),
                              dense: false,
                              leading: const Icon(Icons.remove_red_eye),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${fireService.evs[index]['data']['titre']}',
                                      style: styleTitre),
                                  Text(
                                      '${fireService.evs[index]['data']['infos']}'),
                                ],
                              ),
                              subtitle: Text(
                                  '${fireService.evs[index]['data']['date']}',
                                  style: styleEm,
                                  textAlign: TextAlign.right),
                              trailing: const Icon(Icons.favorite),
                              onTap: () {
                                print(fireService.evs[index]);
                              },
                              onLongPress: () {
                                print("Long pression");
                              })
                        ],
                      );
                    }))
          ]);
        }
        // Si tout est vide
        return logoNul;
      },
    );
  }
}
