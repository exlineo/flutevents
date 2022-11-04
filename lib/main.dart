import 'package:flutevents/pages/carte.dart';
import 'package:flutevents/pages/faim.dart';
import 'package:flutevents/pages/miam.dart';
import 'package:flutevents/pages/vitamines.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/store-service.dart';
import 'utils/lang/Fr.dart';
import 'utils/Config.dart';

void main() async => {
      // Lancement de l'application avec la classe de démarrage
      runApp(const StartApp()),
      // Initialisation de Firebase pour récupérer les données
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      // Récupérer les premières données
      // fireService.getEvs()
    };

// Classe de démarrage, stateless parce qu'il n'y a pas d'interactions sur cette classe
class StartApp extends StatelessWidget {
  // Constructeur de la classe
  const StartApp({super.key});
  // final l = new FR();

  static const String _title = FR.APP;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        theme: ThemeData(
          primaryColor: Colors.pink[900],
          primarySwatch: Colors.pink,
          fontFamily: 'Playfair Display',
          bottomAppBarColor: Colors.pink[900],
        ),
        home: const AccueilStatefulWidget());
  }
}

class AccueilStatefulWidget extends StatefulWidget {
  const AccueilStatefulWidget({super.key});

  @override
  State<AccueilStatefulWidget> createState() => _AccueilStatefulWidgetState();
}

class _AccueilStatefulWidgetState extends State<AccueilStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    VitaminesWidget(),
    CarteWidget(),
    FaimWidget(),
    MiamWidget(),
  ];
  // Evénement sur le bouton qui redéfinit une valeur (setState)
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Image.asset('assets/images/juice.png',
              height: 40, width: 50, fit: BoxFit.fitHeight),
          const Text(FR.APP),
        ]),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(Icons.more_vert),
              )),
        ],
        // title: const Text(FR.APP),
        // theme: AppBarTheme(backgroundColor: Colors.pink[900],)
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          // items: ConfigWidget.bottom,
          items: ConfigWidget.bottomListItems(),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink[900],
          // backgroundColor: Colors.pink[900],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed),
    );
  }
}
