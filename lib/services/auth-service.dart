import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jrestaujus/services/store-service.dart';
import 'package:jrestaujus/services/messages-service.dart';
// Aides sur les notifications
// https://firebase.flutter.dev/docs/messaging/permissions
// https://firebase.google.com/docs/cloud-messaging/flutter/client

class AuthService {
  // Créer un singleton pour partager des données entre les pages et les classes
  static final AuthService _fireService = AuthService._internal();

  factory AuthService() {
    return _fireService;
  }
  AuthService._internal();

  late String userId;
  String? token = '';
  var auth;

  /// Authentifier un utilisateur
  setAuth() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account. ${userCredential}");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  /// Sauvegarder le token d'un utilisateur dans la base de donénes
  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    userId = FirebaseAuth.instance.currentUser!.uid;

    // await fireService.db.collection('users').doc(userId).update({
    await fireService.db.collection('users').doc(userId).set({
      'tokens': FieldValue.arrayUnion([token]),
    }, SetOptions(merge: true));
  }

  /// Récupérer le token et l'enregistrer dans la base de données
  Future<void> setupToken() async {
    // Récupérer le token au chargement de l'application
    String? tok = await msgService.msg.getToken();

    // Envoyer le token dans la base de données
    if (tok != token) {
      await saveTokenToDatabase(tok!);
      token = tok;
      // print("Token : ${_token}");
    }
    // A chaque fois que le token sera réinitialisé, on le renvoie à la base
    msgService.msg.onTokenRefresh.listen(saveTokenToDatabase);
  }

  /// Ecouteur sur l'authentification et ses changements
  checkAuth() {
    // print("Début de l'auth : ${auth}");
    auth = FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print("Utilisateur pas encore authentifié authentifié ${user}");
        setAuth();
      }
    });
    // Récupéré le token
    setupToken();
  }
}

// Intanciation du singleton
final authService = AuthService();
