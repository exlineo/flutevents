import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/store-service.dart';
import 'package:jrestaujus/utils/lang/Fr.dart';
import 'package:jrestaujus/utils/Shared.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Afficher des news tirées de données externes
class FournisseursWidget extends StatefulWidget {
  const FournisseursWidget({super.key});
  // Intégration d'un nouvel état dans le composant
  @override
  State<FournisseursWidget> createState() => _LoadFournisseursWidget();
}

class _LoadFournisseursWidget extends State<FournisseursWidget>
    with UtilsWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fireService.getFutureOrgs(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // Remplace le contenu par un loader en attendant les données
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // Si des données sont reçues, le contenu est
        if (snapshot.hasData) {
          return Column(children: [
            ColoredBox(
              color: Colors.pink,
              child: Padding(
                padding: const EdgeInsets.all(15),
                // child: Expanded(
                child: Center(
                    child: Text(FR.PAGES["fournisseurs"]!["titre"] as String,
                        textAlign: TextAlign.center, style: styleEntete)),
              ),
              // ),
            ),
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: fireService.orgs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: Column(children: [
                        Image.network(
                            fireService.orgs[index]["data"]["vignette"]),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              fireService.orgs[index]["data"]["nom"],
                              style: styleTitre,
                              textAlign: TextAlign.left,
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              fireService.orgs[index]["data"]["infos"],
                              maxLines: 4,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () async => {},
                                child: Icon(Icons.favorite,
                                    color: setFavoriteColor(
                                        fireService.orgs[index]["id"]))),
                            TextButton(
                                onPressed: () => ouvreLien(
                                    fireService.orgs[index]["data"]["site"]),
                                child: const Icon(Icons.insert_link)),
                            TextButton(
                                onPressed: () => sendEmail(
                                    fireService.orgs[index]["data"]["mail"]),
                                child: const Icon(Icons.email)),
                            TextButton(
                                onPressed: () => sendSms(fireService.orgs[index]
                                    ["data"]["portable"]),
                                child: const Icon(Icons.sms)),
                            TextButton(
                                onPressed: () => sendCall(fireService
                                    .orgs[index]["data"]["portable"]),
                                child: const Icon(Icons.local_phone))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 20),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              for (String i in fireService.orgs[index]["data"]
                                  ["activites"]) ...[
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber[300]),
                                    child: Center(child: Text(i)),
                                    height: 30),
                                const SizedBox(width: 10)
                              ]
                            ]),
                          ),
                        )
                      ])
                          // )
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
