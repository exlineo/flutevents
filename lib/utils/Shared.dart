import 'package:jrestaujus/services/store-service.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'lang/Fr.dart';

// liste des icones disponibles : https://fontawesomeicons.com/flutter/icons
// Créer une classe pour stocker des éléments type de configuration (UI et Data)
abstract class SharedWidget extends StatelessWidget {
  SharedWidget({super.key});

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // Liste des éléments du menu en bas de page
  static List<BottomNavigationBarItem> bottomListItems() {
    List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[];

    // Loop pour créer les boutons du menu
    for (var item in FR.BOTTOM_ITEMS) {
      items.add(BottomNavigationBarItem(
        icon: item['icon'] as Widget,
        label: item['label'] as String,
        // tooltip: item['tooltip'] as String,
      ));
    }
    return items;
  }
}

mixin UtilsWidget {
  // Transformer une date à partir d'un timestamp
  setDate(time) {
    // print('Time to date : ${time.toString()}');
    // var d = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    // return DateFormat('dd/MM/yyyy').format(d);
  }
  TextStyle styleMini = const TextStyle(fontSize: 10);
  TextStyle styleEm =
      const TextStyle(fontSize: 12, fontStyle: FontStyle.italic);
  TextStyle styleSt =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  TextStyle styleTitreBlanc = const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle styleTitre =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle styleEntete = const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);

  Widget logoNul = Center(
      child: Column(
    children: [
      Image.asset('assets/images/juice.png'),
      const Text(":/ C'est vide ici",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
    ],
  ));
  setFavoriteColor(String ev) {
    // if (fireService.u['suivis']['evenements'] != null) {
    if (fireService.favEvs.contains(ev) || fireService.favOrgs.contains(ev)) {
      return Colors.pink[600];
    }
    // }
    return Colors.grey[600];
  }

  setLien(var l) {
    Uri lien = Uri(scheme: 'https', path: l);
    // Uri lien = Uri(path: l);
    return lien;
  }

  // Send Email
  setMailto(var l) {
    Uri lien = Uri(
        scheme: 'mailto',
        path: l,
        query:
            "subject=J'reste au jus mais j'ai une question&body=Bonjour... j'a une question");
    return lien;
  }

  // laynch call
  setCall(var l) {
    Uri lien = Uri(scheme: 'tel', path: l);
    return lien;
  }

  // laynch call
  setSms(var l) {
    Uri lien = Uri(scheme: 'sms', path: l);
    return lien;
  }

  ouvreLien(var d) async {
    // if (await canLaunchUrl(setLien(d))) {
    try {
      await launchUrl(setLien(d));
    } catch (e) {
      throw 'Could not launch ${setLien(d)} / ${e.toString()}';
    }
  }

  sendEmail(var d) async {
    if (await canLaunchUrl(setMailto(d))) {
      await launchUrl(setMailto(d));
    } else {
      throw 'Could not launch ${setMailto(d)}';
    }
  }

  sendSms(var d) async {
    if (await canLaunchUrl(setSms(d))) {
      await launchUrl(setSms(d));
    } else {
      throw 'Could not launch ${setSms(d)}';
    }
  }

  sendCall(var d) async {
    if (await canLaunchUrl(setCall(d))) {
      await launchUrl(setCall(d));
    } else {
      throw 'Could not launch ${setCall(d)}';
    }
  }

  /// Renvoyer un cartouche avec un arrière plan jaune pour indiquer un type
  setType(var str) {
    if (str != null) {
      print('${str} conteneur');
      return Container(
          height: 20,
          // width:auto,
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber[300]),
          child: Center(child: Text(str, style: styleMini)));
    }

    return null;
  }
}
