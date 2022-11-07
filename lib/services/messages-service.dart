import 'package:firebase_messaging/firebase_messaging.dart';
// https://firebase.flutter.dev/docs/messaging/permissions

class MsgService {
  // Créer un singleton pour partager des données entre les pages et les classes
  static final MsgService _fireService = MsgService._internal();

  factory MsgService() {
    return _fireService;
  }
  MsgService._internal();
  // Initialisation de Firestore
  final msg = FirebaseMessaging.instance;

  // late NotificationSettings perms;
  var perms;

  /// Lister les permissions en cours
  getPerms() async {
    perms = await msg.getNotificationSettings();
    print('${perms}');
    return perms;
  }

  /// Obtenir l'aval de l'utilisateur
  setPerms() async {
    perms = await msg.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (perms.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (perms.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    return perms;
  }
}

// Intanciation du singleton
final msgService = MsgService();
