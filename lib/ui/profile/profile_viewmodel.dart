import 'package:insta_post/models/User.dart';
import 'package:insta_post/services/user_service.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';

class ProfileViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  UserModel get currentUser => _userService.currentUser!;
}
