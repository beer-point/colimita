import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PushNotificationManager {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static final PushNotificationManager _instance =
      PushNotificationManager._privateContructor();

  factory PushNotificationManager() {
    return _instance;
  }

  PushNotificationManager._privateContructor();

  Future init() async {
    if (!kIsWeb && Platform.isIOS) {
      await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }

    /// TODO(lg): do something with the token
    await firebaseMessaging.getToken(
        vapidKey: 'BM_b9_UDu_i0zo8QCaJysBdaRmjIhUD'
            'dCMOgcnpQmRaXcv_GqyJBBvnRD1dGEbTFxPfhUYZmMIzwqmrZlngXZi4');

    FirebaseMessaging.onMessage.listen((message) {
      print('notificacion recibida en app!: ${message.notification!.body}');
    });

    // TODO(lg): register service worker for web
    /// To register the background message listener for web we need to follow
    /// this guide to register a service worker:
    /// https://firebase.flutter.dev/docs/messaging/usage/#background-messages
    /// the "Web" tab
    if (!kIsWeb) {
      FirebaseMessaging.onBackgroundMessage((message) async {
        print('Notificacion recibida afuerda de la app: '
            '${message.notification!.body}');
      });
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Notificacion que abrio la app: ${message.notification!.body}');
    });

    var initialMessage = await firebaseMessaging.getInitialMessage();

    if (initialMessage != null && initialMessage.notification != null) {
      print('app was opened from a notification '
          '${initialMessage.notification!.body}');
    }
  }
}
