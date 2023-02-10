import 'package:insta_post/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.router.dart';

import '../../app/app.locator.dart';

class HomeViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _nav = locator<NavigationService>();
  Future logout() async {
    await _authenticationService.logout();
    _nav.clearStackAndShow(Routes.signupView);
  }
}
