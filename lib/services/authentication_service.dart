// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:insta_post/app/app.locator.dart';
import 'package:insta_post/app/app.logger.dart';
import 'package:insta_post/app/app.router.dart';
import 'package:insta_post/services/dio_service.dart';

import '../models/User.dart';

class AuthenticationService {
  final logger = getLogger('AuthenticationServie');
  final  _firebaseAuth = FirebaseAuth.instance;
  final _dioService = locator<DioService>();
  final _navigationService = locator<NavigationService>();
  late User user;

  AuthenticationService() {
    _firebaseAuth.onAuthStateChanged.listen((FirebaseUser? user) async {
      if (user == null) {
        logger.v('user is logged out');
      } else {
        logger.v('user is logged in');
        populateUser(firebaseUid: user.uid);
      }
    });
  }

  Future<void> populateUser({required String firebaseUid}) async {
    try {
      user = await _dioService.getUser(firebaseUid);
      _navigationService.clearStackAndShow(Routes.homeView);
    } catch (e) {
      _navigationService.clearStackAndShow(Routes.registrationView);
    }
  }

}
