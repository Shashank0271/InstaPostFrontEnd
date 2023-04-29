import 'package:insta_post/app/app.router.dart';
import 'package:insta_post/services/dio_service.dart';
import 'package:insta_post/services/dynamic_link_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../models/Post.dart';
import '../../../../services/authentication_service.dart';

class BlogCardModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dynamicLinkService = locator<DynamicLinkService>();
  final _dioService = locator<DioService>();
  final _authenticationService = locator<AuthenticationService>();
  bool liked = false;
  void navigateToDetailsPage(Post currentPost) {
    _navigationService.navigateTo(Routes.postDetailsView,
        arguments: PostDetailsViewArguments(currentPost: currentPost));
  }

  Future sharePost(String id) async {
    final generatedLink = await _dynamicLinkService.createPostLink(postID: id);
    await Share.share(generatedLink);
  }

  Future toggleLikes({required String postId}) async {
    liked = !liked;
    notifyListeners();
    if (liked) {
      await _dioService.likePost(
          postId: postId,
          firebaseUid: _authenticationService.firebaseUser!.uid);
    } else {
      await _dioService.unlikePost(
          postId: postId,
          firebaseUid: _authenticationService.firebaseUser!.uid);
    }
  }
}
