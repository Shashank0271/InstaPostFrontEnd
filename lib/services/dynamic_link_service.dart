import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:insta_post/app/app.locator.dart';
import 'package:insta_post/app/app.logger.dart';
import 'package:insta_post/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import '../models/Post.dart';
import 'dio_service.dart';

class DynamicLinkService {
  final _logger = getLogger('DynamicLinkService');
  final _navigationService = locator<NavigationService>();
  final _dioService = locator<DioService>();

  //when we create a post link for currentUser to share :
  Future<String> createPostLink({required String postID}) async {
    final String url = 'https://www.instapost.com/post?pid=$postID';

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://shanky2002.page.link',
      link: Uri.parse(url),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.insta_post',
      ),
    );

    final firebaseDynamicLinks = FirebaseDynamicLinks.instance;
    final refLink = await firebaseDynamicLinks.buildShortLink(parameters);

    return refLink.shortUrl.toString();
  }

  //when the current user gets a shared link to open the app :
  Future<void> handleDynamicLinks() async {
    final PendingDynamicLinkData? pendingDynamicLinkData =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(pendingDynamicLinkData);

    //Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink
        .listen((PendingDynamicLinkData pendingDynamicLinkData) {
      if (pendingDynamicLinkData != null) {
        _handleDeepLink(pendingDynamicLinkData);
      }
    });
  }

  Future<void> _handleDeepLink(
      PendingDynamicLinkData? pendingDynamicLinkData) async {
    //if its not null it means that the user opens the app through my link:
    if (pendingDynamicLinkData != null) {
      final Uri deepLink = pendingDynamicLinkData.link;
      _logger.v('_handleDeepLink | deeplink: $deepLink');
      if (deepLink.queryParameters.containsKey('pid')) {
        //if the link contains this query parameter then fetch the
        //post using pid and perform the navigation
        final Post? requiredPost =
            await _dioService.getPost(deepLink.queryParameters['pid']!);
        _navigationService.navigateTo(Routes.postDetailsView,
            arguments: PostDetailsViewArguments(currentPost: requiredPost!));
      }
    }
  }

}
