import 'package:flutter/material.dart';

// Afficher des news tirées de données externes
class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});
  // Intégration d'un nouvel état dans le composant
  @override
  State<NewsWidget> createState() => _LoadNewsWidget();
}

class _LoadNewsWidget extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Text('News en route');
  }
}
