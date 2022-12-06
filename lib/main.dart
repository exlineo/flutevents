import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:jrestaujus/pages/chauffe.dart';
import 'package:jrestaujus/pages/faim.dart';
import 'package:jrestaujus/pages/fournisseurs.dart';
import 'package:jrestaujus/pages/vitamines.dart';

import 'package:jrestaujus/services/auth-service.dart';
import 'package:jrestaujus/services/messages-service.dart';
import 'firebase_options.dart';

import 'package:jrestaujus/utils/Shared.dart';
import 'package:jrestaujus/utils/lang/Fr.dart';

void main() async => {
      // Assurer le démarrage de l'application pour éviter les erreurs avec Firebase
      WidgetsFlutterBinding.ensureInitialized(),
      // Initialisation de Firebase pour récupérer les données
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      // Lancement de l'application avec la classe de démarrage
      runApp(const StartApp()),
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink[900],
          primarySwatch: Colors.pink,
          fontFamily: 'Playfair Display',
          bottomAppBarColor: Colors.pink[900],
        ),
        home: const AccueilStatefulWidget());
  }
}

/// Initialisation de l'application de démarrage
class AccueilStatefulWidget extends StatefulWidget {
  const AccueilStatefulWidget({super.key});
  // Création d'un Widget
  @override
  State<AccueilStatefulWidget> createState() => _AccueilStatefulWidgetState();
}

class _AccueilStatefulWidgetState extends State<AccueilStatefulWidget>
    with UtilsWidget {
  final PageController controller = PageController(
    initialPage: 0,
    keepPage: true,
  );
  // Index de la page à afficher
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    VitaminesWidget(),
    ChauffeWidget(),
    FaimWidget(),
    FournisseursWidget(),
  ];

  /// Evénement sur un bouton du menu du bas qui redéfinit une valeur (setState)
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    controller.animateToPage(
      _selectedIndex,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer la liste des permissions sur les notifications
    // if (msgService.perms == null) msgService.setPerms();
    msgService.getPerms();

    /// Vérifier la connexion de l'utisateur et récupérer le token du téléphone
    authService.checkAuth();

    // Afficher la page principale
    return Scaffold(
      // Eviter d'ouvrir les paramètres avec un glissement de doigt
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Row(children: [
          Image.asset('assets/images/juice.png',
              height: 40, width: 50, fit: BoxFit.fitHeight),
          const Text(FR.APP),
        ]),
        actions: [
          Builder(
            builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: const Icon(Icons.more_vert),
                )),
          )
        ],
        backgroundColor: Colors.pink[900],
        // theme: AppBarTheme(backgroundColor: Colors.pink[900],)
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.pink,
              ),
              child: Center(
                  child:
                      Expanded(child: Image.asset('assets/images/profil.png'))),
            ),
            Center(child: Text('Anonymos', style: styleTitre)),
            ListTile(
                leading: const Icon(Icons.sms_failed),
                title: Text('Token : ${authService.token}')),
            ListTile(
                leading: Switch(
                    // Valeur actuelle du Switch
                    value: msgService.notifs,
                    activeColor: Colors.pinkAccent,
                    onChanged: (bool value) {
                      // msgService.setPerms();
                      setState(() {
                        msgService.notifs = value;
                      });
                    }),
                title: const Text('Autoriser les notifications')),
          ],
        ),
      ),
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _widgetOptions,
      ),
      // body: Center(
      //   child: _widgetOptions.elementAt(_selectedIndex),
      // ),
      bottomNavigationBar: BottomNavigationBar(
          // items: SharedWidget.bottom,
          items: SharedWidget.bottomListItems(),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink[900],
          // backgroundColor: Colors.pink[900],
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed),
    );
  }
}
