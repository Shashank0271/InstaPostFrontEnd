import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:insta_post/app/app.locator.dart';
import 'package:insta_post/app/app.router.dart';
import 'package:insta_post/services/localnotification_service.dart';
import 'package:stacked_services/stacked_services.dart';
import '../app/app.logger.dart';
import '../models/Post.dart';
import 'dio_service.dart';

final FirebaseMessaging messaging = FirebaseMessaging.instance;
final _navigationService = locator<NavigationService>();
final _dioService = locator<DioService>();
final log = getLogger('PushNotificationService');
late String? myFcmToken;

Future setUpFcm() async {
  myFcmToken = await messaging.getToken();
  log.i('Users fcm reg token :$myFcmToken');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 1. This method call when app in terminated state and you get a notification
  await FirebaseMessaging.instance.getInitialMessage().then(
    (RemoteMessage? message) {
      log.v("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        log.d("New Notification");
      }
    },
  );
  // 2. This method only call when App in forground it mean app must be opened
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      log.v("FirebaseMessaging.onMessage.listen");
      log.v(message.data);
      if (message.notification != null) {
        log.v(message.notification!.title);
        log.v(message.notification!.body);
        log.v("message.data11 ${message.data}");
        LocalNotificationService.createanddisplaynotification(message);
        handleMessage(postId: message.data['postId']);
      }
    },
  );
  // 3. This method only call when App in background and not terminated(not closed)
  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) {
      log.v("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        log.d(message.notification!.title);
        log.d(message.notification!.body);
      }
    },
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log.i("Handling a background message: ${message.messageId}");
}

handleMessage({String? postId}) async {
  if (postId != null) {
    Post? requiredPost = await _dioService.getPost(postId);
    _navigationService.navigateTo(Routes.postDetailsView,
        arguments: PostDetailsViewArguments(currentPost: requiredPost!));
  }
}
