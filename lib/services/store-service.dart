import 'package:cloud_firestore/cloud_firestore.dart';

class FireService {
  // Créer un singleton pour partager des données entre les pages et les classes
  static final FireService _fireService = new FireService._internal();

  factory FireService() {
    return _fireService;
  }
  FireService._internal();

  // Initialisation de Firestore
  final db = FirebaseFirestore.instance;

  late List<Map<String, dynamic>> _evenements =
      []; // Liste des événements chargés depuis Firestore
  late List<Map<String, dynamic>> _organimses =
      []; // Liste des organismes chargés depuis Firestore
  late Map<String, dynamic> _compte =
      {}; // Compte de l'utilisateur avec ses favoris

  // Récupérer les événements depuis Firebase
  List<Map<String, dynamic>> getEvs() {
    if (_evenements.isEmpty) {
      getFireEvs();
    }
    print('-------- depuis fireservice sans reload --------');
    return _evenements;
  }

  getFireEvs() async {
    await db.collection("evenements").get().then((event) {
      for (var doc in event.docs) {
        // print("${doc.id} => ${doc.data()}");
        _evenements.add({"id": doc.id, "data": doc.data()});
      }
    });
  }
  // Récupérer la liste des événements
}

// Intanciation du singleton
final fireService = FireService();
