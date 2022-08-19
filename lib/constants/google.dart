import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bacheo_brigada/firebase_options.dart';

final Future<FirebaseApp> initialize =
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
final FirebaseMessaging fcm = FirebaseMessaging.instance;
