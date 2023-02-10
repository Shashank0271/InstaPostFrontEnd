import 'package:insta_post/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../services/user_service.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final log = getLogger('StartupViewModel');
  initialise() async{
    if (_authenticationService.isUserSignedIn) {
      log.v('syncing user from db');
      await _userService.syncUserAccount();
      _navigationService.clearStackAndShow(Routes.homeView);
    } else {
      _navigationService.navigateTo(Routes.loginView);
    }
  }
}
