import 'package:insta_post/services/dio_service.dart';
import 'package:insta_post/services/image_service.dart';
import 'package:insta_post/services/pushnotification_service.dart';
import 'package:insta_post/ui/create-posts/createpost_view.dart';
import 'package:insta_post/ui/editposts/editpost_view.dart';
import 'package:insta_post/ui/home/home_view.dart';
import 'package:insta_post/ui/postsdetails/postdetails_view.dart';
import 'package:insta_post/ui/sign-up/signup_view.dart';
import 'package:insta_post/ui/viewprofile/viewprofile_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../services/authentication_service.dart';
import '../services/dynamic_link_service.dart';
import '../services/user_service.dart';
import '../ui/login/login_view.dart';
import '../ui/myposts/myposts_view.dart';
import '../ui/profile/profile_view.dart';
import '../ui/startup/startup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: PostDetailsView),
    MaterialRoute(page: CreatePostView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: ViewProfileView),
    MaterialRoute(page: MyPostsView),
    MaterialRoute(page: EditPostView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: DioService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: ImageService),
    Singleton(classType: AuthenticationService),
    Singleton(classType: DynamicLinkService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /*serves no purpose except having an annotation attached to it*/
}
//run "flutter pub run build_runner build --delete-conflicting-outputs" after making changes