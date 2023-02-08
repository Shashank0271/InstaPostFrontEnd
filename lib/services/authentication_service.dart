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
  final _firebaseAuth = FirebaseAuth.instance;
  final _dioService = locator<DioService>();
  final _navigationService = locator<NavigationService>();
  late UserModel user;
  late User firebaseUser;
  bool isUserSignedIn = false;
  AuthenticationService() {
    _firebaseAuth.authStateChanges().listen((User? user) async {
      if (user == null) {
        logger.v('user is logged out');
      } else {
        logger.v('user is logged in');
        isUserSignedIn = true;
        firebaseUser = user;
        populateUser(firebaseUid: user.uid);
      }
    });
  }

  Future loginUser({required String email, password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logger.e('The password provided is too weak.');
        rethrow;
      } else if (e.code == 'email-already-in-use') {
        logger.e('The account already exists for that email.');
        rethrow;
      }
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
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
