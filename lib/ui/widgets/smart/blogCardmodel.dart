import 'package:insta_post/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/Post.dart';

class BlogCardModel extends BaseViewModel {
  final _navigationService = NavigationService();
  void navigateToDetailsPage(Post currentPost) {
    _navigationService.navigateTo(Routes.postDetailsView,
        arguments: PostDetailsViewArguments(currentPost: currentPost));
  }
}
