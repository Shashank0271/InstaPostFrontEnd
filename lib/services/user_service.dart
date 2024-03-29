import 'package:insta_post/models/User.dart';
import 'package:insta_post/services/authentication_service.dart';
import 'package:insta_post/services/dio_service.dart';
import 'pushnotification_service.dart' as FCMService;
import '../app/app.locator.dart';
import '../app/app.logger.dart';

class UserService {
  final _authenticationService = locator<AuthenticationService>();
  final _dioService = locator<DioService>();
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  set setUser(UserModel? value) {
    _currentUser = value;
  }

  final log = getLogger('UserService');

  Future<void> syncUserAccount() async {
    log.d("entered sync user method");

    final firebaseUserId = _authenticationService.firebaseUser!.uid;

    log.v('Sync user $firebaseUserId');
    try {
      final userAccount =
          await _dioService.getUser(firebaseUid: firebaseUserId);
      log.v('User account exists. Save as _currentUser');
      _currentUser = userAccount;
      log.d(_currentUser);
    } catch (e) {
      log.v('User does not exist in database .');
    }
    return;
  }

  Future<void> syncOrCreateUserAccount({required UserModel user}) async {
    log.i('user:$user');

    await syncUserAccount();

    if (_currentUser == null) {
      log.v('We have no user account. Create a new user ...');
      user.firebaseUid = _authenticationService.firebaseUser!.uid;
      user.registrationToken = FCMService.myFcmToken!;
      await _dioService.createUser(user: user);
      _currentUser = user;

      log.v('_currentUser has been saved');
    }
  }
}
