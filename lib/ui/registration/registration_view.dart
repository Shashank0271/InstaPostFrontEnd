import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'registration_viewmodel.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegistrationViewModel>.reactive(
      builder: (context, model, child) => const Scaffold(
        body: Center(child: Text('registration screen')),
      ),
      viewModelBuilder: () => RegistrationViewModel(),
    );
  }
}
