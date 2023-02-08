import 'package:flutter/material.dart';
import 'package:insta_post/ui/sign-up/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(
            child: TextButton(
          onPressed: () {
            const snackBar = SnackBar(
              content: Text('Yay! A SnackBar!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          child: Text('asdasd'),
        )),
      ),
      viewModelBuilder: () => SignupViewModel(),
    );
  }
}
