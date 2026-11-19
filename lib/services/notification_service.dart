
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  debugPrint(
    '[BACKGROUND] ${message.notification?.title}',
  );
  debugPrint(
    '[BACKGROUND] ${message.notification?.body}',
  );
}

class NotificationService {
  NotificationService._();

  static final NotificationService instance =
      NotificationService._();

  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  Future<NotificationSettings> requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint(
      'Notification permission status: ${settings.authorizationStatus}',
    );

    return settings;
  }

  Future<String?> getFCMToken() async {
    // ignore: deprecated_member_use
    final token = await _messaging.getToken();

    debugPrint('FCM Token: $token');

    return token;
  }

  Future<void> init() async {
    await requestPermission();
    await getFCMToken();

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        debugPrint('[FOREGROUND] Notification received');
        debugPrint('title: ${message.notification?.title}');
        debugPrint('body: ${message.notification?.body}');
        debugPrint('data: ${message.data}');
      },
    );
  }
}
