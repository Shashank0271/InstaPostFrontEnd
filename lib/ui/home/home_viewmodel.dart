import 'package:insta_post/services/authentication_service.dart';
import 'package:insta_post/services/dio_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.router.dart';

import '../../app/app.locator.dart';
import '../../models/Post.dart';

class HomeViewModel extends FutureViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _dioService = locator<DioService>();
  final _nav = locator<NavigationService>();
   List<Post> _allposts = [];
  List<Post> get allPosts => _allposts;
  // final _imageService = locator<ImageService>();
  Future logout() async {
    await _authenticationService.logout();
    _nav.clearStackAndShow(Routes.loginView);
  }

  @override
  Future futureToRun() async {
    _allposts = await _dioService.getAllPosts();
  }
}
