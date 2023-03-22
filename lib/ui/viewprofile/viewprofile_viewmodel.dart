import 'package:insta_post/services/dio_service.dart';
import 'package:insta_post/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class ViewProfileViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _dioService = locator<DioService>();
  final _snackbarService = locator<SnackbarService>();
  Future<void> followUser(
      {required String followedUserFid, required String userName}) async {
    var currentUserFid = _userService.currentUser!.firebaseUid;
    if (followedUserFid == currentUserFid) {
      return;
    }
    await _dioService.follow(
        currentUserFid: currentUserFid, followedUserFid: followedUserFid);
    _snackbarService.showSnackbar(message: 'you are now following $userName');
  }
}
