import 'package:cloud_firestore/cloud_firestore.dart';

class FireService {
  // Créer un singleton pour partager des données entre les pages et les classes
  static final FireService _fireService = FireService._internal();

  factory FireService() {
    return _fireService;
  }
  FireService._internal();
  // Initialisation de Firestore
  final db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> evs =
      []; // Liste des événements chargés depuis Firestore
  List<Map<String, dynamic>> orgs =
      []; // Liste des organismes chargés depuis Firestore
  Map<String, dynamic> u = {}; // Compte de l'utilisateur avec ses favoris
  // Future<List<Map<String, dynamic>>> evsSync() {
  //   return getEvs();
  // }

  // Récupérer les événements depuis Firebase
  getEvs() async {
    if (evs.isEmpty) {
      await getFireEvs();
    }
    // print('${evs.isEmpty} > ${evs}');
    return evs;
  }

  /// Récupérer les données d'une manière classique
  getFireEvs() async {
    await db.collection("evenements").get().then((event) {
      evs = [];
      for (var doc in event.docs) {
        evs.add({"id": doc.id, "data": doc.data()});
      }
    }).catchError((er) => {print(er)});
  }

  /// Récupérer la liste en la syncrhonisant avec le rendu (uturBuilder) dans les pages
  Future<List<dynamic>> getFutureEvs() async {
    if (evs.isEmpty) {
      await db.collection("evenements").get().then((event) {
        for (var doc in event.docs) {
          evs.add({"id": doc.id, "data": doc.data()});
        }
      }).catchError((er) => {print(er)});
    }
    return evs;
  }

  /// Récupérer la liste en la syncrhonisant avec le rendu (uturBuilder) dans les pages
  Future<List<dynamic>> getFutureOrgs() async {
    if (evs.isEmpty) {
      await db.collection("organismes").get().then((event) {
        for (var doc in event.docs) {
          orgs.add({"id": doc.id, "data": doc.data()});
        }
      }).catchError((er) => {print(er)});
    }
    return orgs;
  }
}

// Intanciation du singleton
final fireService = FireService();
