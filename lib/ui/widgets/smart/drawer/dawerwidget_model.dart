import 'package:flutter/material.dart';
import 'package:insta_post/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../services/authentication_service.dart';
import '../../../../services/user_service.dart';

class DrawerWidgetModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  String get accountName => _userService.currentUser!.username;
  String get accountEmail => _userService.currentUser!.email;
  navigateToHomePage() => _navigationService.clearStackAndShow(Routes.homeView);
  navigateToProfilePage() => _navigationService.navigateTo(Routes.profileView);
  logout() {
    _authenticationService.logout();
    _userService.setUser = null;
    _navigationService.clearStackAndShow(Routes.loginView);
  }
}
