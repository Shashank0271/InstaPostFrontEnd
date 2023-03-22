import 'package:insta_post/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../models/User.dart';
import '../../services/dio_service.dart';

class PostDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dioService = locator<DioService>();

  void viewProfile(String userFirebaseId) async {
    UserModel postUser = await _dioService.getUser(firebaseUid: userFirebaseId);
    _navigationService.navigateTo(Routes.viewProfileView,
        arguments: ViewProfileViewArguments(userInfo: {
          "username": postUser.username,
          "email": postUser.email,
          "followers": postUser.followers,
          "following": postUser.following,
          "postCount": postUser.postCount,
          "firebaseUid": postUser.firebaseUid
        }));
  }
}
