import 'package:insta_post/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../models/Post.dart';
import '../../services/dio_service.dart';

class MyPostsViewModel extends FutureViewModel {
  final _dioService = locator<DioService>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  List<Post> myPostList = [];

  @override
  Future futureToRun() async {
    myPostList = await _dioService.getCurrentUsersPosts(
        firebaseUid: _userService.currentUser!.firebaseUid);
  }

  void navigateToEditPostScreen({required Post selectedPost}) {
    _navigationService.navigateTo(Routes.editPostView,
        arguments: EditPostViewArguments(post: selectedPost));
  }
}
