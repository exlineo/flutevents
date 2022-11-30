import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jrestaujus/services/store-service.dart';
import 'package:jrestaujus/services/messages-service.dart';
// https://firebase.flutter.dev/docs/messaging/permissions

class AuthService {
  // Créer un singleton pour partager des données entre les pages et les classes
  static final AuthService _fireService = AuthService._internal();

  factory AuthService() {
    return _fireService;
  }
  AuthService._internal();

  late String userId;
  String? _token = '';
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
    // Get the token each time the application loads
    String? token = await msgService.msg.getToken();

    // Save the initial token to the database
    if (token != _token) {
      await saveTokenToDatabase(token!);
      _token = token;
      // print("Token : ${_token}");
    }
    // Any time the token refreshes, store this in the database too.
    msgService.msg.onTokenRefresh.listen(saveTokenToDatabase);
  }

  /// Ecouteur sur l'authentification et ses changements
  checkAuth() {
    // print("Début de l'auth : ${auth}");
    auth = FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print("Utilisateur pas encore authentifié authentifié ${user}");
        setAuth();
      } else {
        // print("Utilisateur authentifié ${user}");
      }
    });
    // Récupéré le token
    setupToken();
  }
}

// Intanciation du singleton
final authService = AuthService();
