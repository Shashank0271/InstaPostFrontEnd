import 'package:insta_post/services/dio_service.dart';
import 'package:insta_post/ui/home/home_view.dart';
import 'package:insta_post/ui/registration/registration_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../services/authentication_service.dart';
import '../ui/login/login_view.dart';
import '../ui/startup/startup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegistrationView),
    MaterialRoute(page: HomeView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: DialogService),
    Singleton(classType: AuthenticationService),
    LazySingleton(classType: DioService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /*serves no purpose except having an annotation attached to it*/
}
//run "flutter pub run build_runner build --delete-conflicting-outputs" after making changes