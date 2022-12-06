import 'package:firebase_messaging/firebase_messaging.dart';
// https://firebase.flutter.dev/docs/messaging/permissions

class MsgService {
  // Créer un singleton pour partager des données entre les pages et les classes
  static final MsgService _fireService = MsgService._internal();

  factory MsgService() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    return _fireService;
  }
  MsgService._internal();

  // Initialisation de Firestore
  final msg = FirebaseMessaging.instance;
  bool notifs = false;
  // late NotificationSettings perms;
  late NotificationSettings perms;

  /// Lister les permissions en cours
  getPerms() async {
    perms = await msg.getNotificationSettings();
    perms.authorizationStatus == AuthorizationStatus.authorized
        ? notifs = true
        : false;
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
      notifs = true;
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
