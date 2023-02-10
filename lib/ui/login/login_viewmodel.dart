import 'package:flutter/material.dart';
import 'package:insta_post/app/app.locator.dart';
import 'package:insta_post/app/app.router.dart';
import 'package:insta_post/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../services/user_service.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _snackbarService = locator<SnackbarService>();
  final _userService = locator<UserService>();
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void navigateToSignupView() {
    _navigationService.navigateTo(Routes.signupView);
  }

  Future loginUser() async {
    String email = emailController.text.trim().toString();
    String password = emailController.text.trim().toString();
    if (email.isEmpty || password.isEmpty) {
      _snackbarService.showSnackbar(
          title: 'incomplete details', message: 'please enter all the details');
    } else {
      try {
        setBusy(true);
        await _authenticationService
            .loginUser(email: email, password: password)
            .then((value) async {
          await _userService.syncUserAccount();
          _navigationService.clearStackAndShow(Routes.homeView);
        });
        setBusy(false);
      } catch (e) {
        setBusy(false);
        _snackbarService.showSnackbar(message: e.toString());
      }
    }
  }
}
