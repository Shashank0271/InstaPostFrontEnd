import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_post/app/app.locator.dart';
import 'package:insta_post/app/app.router.dart';
import 'package:insta_post/ui/shared/setup_snackbar_ui.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupLocator();
  setupSnackbarUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.orange,
          textTheme: TextTheme(
              displaySmall: GoogleFonts.playfairDisplay(
                fontSize: 16,
              ),
              headlineLarge: GoogleFonts.alice(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ))),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
//flutter run --no-sound-null-safety
