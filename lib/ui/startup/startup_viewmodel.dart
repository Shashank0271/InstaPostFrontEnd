import 'package:insta_post/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  initialise() {
    if (_authenticationService.isUserSignedIn) {
    } else {
      _navigationService.navigateTo(Routes.loginView);
    }
  }
}
