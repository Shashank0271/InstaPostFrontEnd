import 'dart:math';

import 'package:insta_post/app/app.logger.dart';
import 'package:insta_post/services/authentication_service.dart';
import 'package:insta_post/services/dio_service.dart';
import 'package:insta_post/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.router.dart';
import '../../app/app.locator.dart';
import '../../models/Post.dart';

class HomeViewModel extends FutureViewModel {
  final _authenticationService = locator<AuthenticationService>();
  final _dioService = locator<DioService>();
  final _navigationService = locator<NavigationService>();
  final _logger = getLogger('HomeView-model');
  final _userService = locator<UserService>();
  List<Post> _allposts = [];
  List<Post> get allPosts => _allposts;

  Future logout() async {
    await _authenticationService.logout();
    _navigationService.clearStackAndShow(Routes.loginView);
  }

  navigateToCreatePostScreen() {
    _navigationService.navigateTo(Routes.createPostView);
  }

  Future<void> refresh() async {
    _logger.d(_userService.currentUser!.firebaseUid);
    _allposts = await _dioService.getAllPosts();
    notifyListeners();
  }

  @override
  Future futureToRun() async {
    _allposts = await _dioService.getAllPosts();
  }
}
