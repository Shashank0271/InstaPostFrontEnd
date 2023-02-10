import 'package:flutter/material.dart';
import 'package:insta_post/ui/sign-up/signup_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../shared/ui_helper.dart';

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 40, top: 64, right: 24),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'We\'ve got some amazing things to show you!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 36),
                ),
                verticalSpaceLarge,
                TextField(
                  controller: model.usernameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'userName',
                  ),
                ),
                verticalSpaceMedium,
                TextField(
                  controller: model.emailController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'email',
                  ),
                ),
                verticalSpaceMedium,
                TextField(
                  controller: model.passwordController,
                  // obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'password',
                  ),
                ),
                verticalSpaceLarge,
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: screenWidthPercentage(context, percentage: 0.4),
                    height: screenHeight(context) / 11,
                    child: ElevatedButton(
                      onPressed: model.createAccount,
                      child: model.isBusy
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.black,
                            ))
                          : Text(
                              'Sign-up',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 24),
                            ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
      viewModelBuilder: () => SignupViewModel(),
    );
  }
}
