import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_post/app/app.logger.dart';

class AuthenticationService {
  final logger = getLogger('AuthenticationServie');
  final _firebaseAuth = FirebaseAuth.instance;
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
      }
    });
  }

  Future loginUser({required String email, required String password}) async {
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

  Future signUpUser(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
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
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

}
