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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 40, top: 128, right: 24),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'We\'ve got some amazing things to show you!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 42),
                  ),
                  verticalSpaceMassive,
                  TextField(
                    controller: model.usernameController,
                    decoration: const InputDecoration(
                      hintText: 'userName',
                    ),
                  ),
                  verticalSpaceMedium,
                  TextField(
                    controller: model.emailController,
                    decoration: const InputDecoration(
                      hintText: 'email',
                    ),
                  ),
                  verticalSpaceMedium,
                  TextField(
                    controller: model.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'password',
                    ),
                  ),
                  verticalSpaceMassive,
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
      ),
      viewModelBuilder: () => SignupViewModel(),
    );
  }
}
