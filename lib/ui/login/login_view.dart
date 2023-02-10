import 'package:flutter/material.dart';
import 'package:insta_post/ui/shared/ui_helper.dart';
import 'package:stacked/stacked.dart';
import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 40, top: 128, right: 24),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back !',
                  style: Theme.of(context).textTheme.headlineLarge,
                  maxLines: 2,
                ),
                verticalSpaceMassive,
                TextField(
                  controller: model.emailController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: 'email',
                  ),
                ),
                verticalSpaceLarge,
                TextField(
                  controller: model.passwordController,
                  // obscureText: true,
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
                      onPressed: model.loginUser,
                      child: model.isBusy
                          ? const Center(child: CircularProgressIndicator())
                          : Text(
                              'Login',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 24),
                            ),
                    ),
                  ),
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New user ?'),
                    horizontalSpaceTiny,
                    GestureDetector(
                      onTap: model.navigateToSignupView,
                      child: const Text(
                        'Sign up.',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                )
              ]),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
