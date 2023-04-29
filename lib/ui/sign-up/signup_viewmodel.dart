import 'package:flutter/material.dart';
import 'package:insta_post/app/app.router.dart';
import 'package:insta_post/services/authentication_service.dart';
import 'package:insta_post/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../models/User.dart';

class SignupViewModel extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  final _authenticationService = locator<AuthenticationService>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> createAccount() async {
    final email = emailController.text.trim().toString();
    final password = passwordController.text.trim().toString();
    final userName = usernameController.text.trim().toString();

    if (email.isEmpty || password.isEmpty || userName.isEmpty) {
      _snackbarService.showSnackbar(message: 'please fill in all details');
    } else {
      try {
        setBusy(true);
        await _authenticationService.signUpUser(
          email: email,
          password: password,
        );

        final userAccount = UserModel(
          username: userName,
          email: email,
          firebaseUid: _authenticationService.firebaseUser!.uid,
          registrationToken: ' ',
          followersTokens: [],
          followers: [],
          following: [],
          likedPosts: [],
          postCount: 0,
        );

        await _userService.syncOrCreateUserAccount(user: userAccount).then(
            (value) => _navigationService.clearStackAndShow(Routes.homeView));

        setBusy(false);
      } catch (e) {
        setBusy(false);
        _snackbarService.showSnackbar(message: e.toString());
      }
    }
  }
}
