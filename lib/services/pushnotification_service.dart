import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:insta_post/services/localnotification_service.dart';

import '../app/app.logger.dart';

final FirebaseMessaging messaging = FirebaseMessaging.instance;
final log = getLogger('PushNotificationService');

late String? myFcmToken;

Future setUpFcm() async {
  myFcmToken = await messaging.getToken();
  log.d('Users fcm reg token :$myFcmToken');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  // 1. This method call when app in terminated state and you get a notification
  // when you click on notification app open from terminated state and you can get notification data in this method
  await FirebaseMessaging.instance.getInitialMessage().then(
    (message) {
      log.v("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        log.d("New Notification");
      }
    },
  );
  // 2. This method only call when App in forground it mean app must be opened
  FirebaseMessaging.onMessage.listen(
    (message) {
      log.v("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        log.v(message.notification!.title);
        log.v(message.notification!.body);
        log.v("message.data11 ${message.data}");
        LocalNotificationService.createanddisplaynotification(message);
      }
    },
  );
  // 3. This method only call when App in background and not terminated(not closed)
  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) {
      log.v("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        log.d(message.notification!.title);
        log.d(message.notification!.body);
        log.d("message.data22 ${message.data['_id']}");
      }
    },
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log.i("Handling a background message: ${message.messageId}");
}
