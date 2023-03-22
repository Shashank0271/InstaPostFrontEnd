import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_post/app/app.logger.dart';

class AuthenticationService {
  final logger = getLogger('AuthenticationServie');
  final _firebaseAuth = FirebaseAuth.instance;
  User? firebaseUser;
  bool isUserSignedIn = false;

  AuthenticationService() {
    _firebaseAuth.authStateChanges().listen((User? user) async {
      if (user == null) {
        isUserSignedIn = false;
        logger.v("user is currently signed out !");
      } else {
        isUserSignedIn = true;
        firebaseUser = user;
        logger.v("user is currently signed in !");
      }
    });
  }

  Future loginUser({required String email, required String password}) async {
    logger.d("entered login user method");
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logger.e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        logger.e('The account already exists for that email.');
      }
      rethrow;
    } catch (e) {
      logger.e(e.toString());
      rethrow;
    }
  }

  Future signUpUser({
    required String email,
    required String password,
  }) async {
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
    //we have to remove the user from disk also:
    await _firebaseAuth.signOut();
  }
}
