import 'package:flutevents/pages/vitamines.dart';
import 'package:flutter/material.dart';
import 'utils/lang/Fr.dart';
import 'utils/Config.dart';

void main() => runApp(const StartApp());

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
        home: const MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    VitaminesWidget(),
    // Text(
    //   'Index 0: Home',
    //   style: optionStyle,
    // ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: Menu',
      style: optionStyle,
    ),
    Text(
      'Index 3: Paramètres',
      style: optionStyle,
    ),
    Text(
      'Index 4 : Infos',
      style: optionStyle,
    ),
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
        title: const Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Center(child: Text(FR.APP))),
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
