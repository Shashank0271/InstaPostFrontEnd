import 'package:insta_post/models/User.dart';
import 'package:insta_post/services/authentication_service.dart';
import 'package:insta_post/services/dio_service.dart';

import '../app/app.locator.dart';
import '../app/app.logger.dart';

class UserService {
  final _authenticationService = locator<AuthenticationService>();
  final _dioService = locator<DioService>();
  UserModel? _currentUser;
  final log = getLogger('UserService');

  Future<void> syncUserAccount() async {
    final firebaseUserId = _authenticationService.firebaseUser.uid;
    log.v('Sync user $firebaseUserId');
    try {
      final userAccount =
          await _dioService.getUser(firebaseUid: firebaseUserId);
      log.v('User account exists. Save as _currentUser');
      _currentUser = userAccount;
    } catch (e) {
      log.v('User does not exist in database .');
    }
  }

  Future<void> syncOrCreateUserAccount({required UserModel user}) async {
    log.i('user:$user');
    await syncUserAccount();
    if (_currentUser == null) {
      log.v('We have no user account. Create a new user ...');
      user.firebaseUid = _authenticationService.firebaseUser.uid;
      await _dioService.createUser(user: user);
      _currentUser = user;
      log.v('_currentUser has been saved');
    }
  }

}
