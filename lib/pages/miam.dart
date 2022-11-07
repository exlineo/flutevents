import 'dart:math';

import 'package:flutter/material.dart';
import '../services/store-service.dart';
import 'package:jrestaujus/utils/lang/Fr.dart';
import 'package:jrestaujus/utils/Shared.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Afficher des news tirées de données externes
class MiamWidget extends StatefulWidget {
  const MiamWidget({super.key});
  // Intégration d'un nouvel état dans le composant
  @override
  State<MiamWidget> createState() => _LoadMiamWidget();
}

class _LoadMiamWidget extends State<MiamWidget> with UtilsWidget {
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
                    child: Text("Miam ! y a quoi de bien ?",
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
                          ListTile(
                              // visualDensity: const VisualDensity(vertical: 4),
                              dense: false,
                              minLeadingWidth: 150,
                              horizontalTitleGap: 10,
                              // minVerticalPadding: 0,
                              // leading: Image.network(
                              // fireService.evs[index]['data']['media']),
                              leading: Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(fireService
                                            .evs[index]['data']['media']),
                                        fit: BoxFit.cover),
                                    // child:
                                  )),
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
