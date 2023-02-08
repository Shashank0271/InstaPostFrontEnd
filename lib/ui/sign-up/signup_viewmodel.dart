import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class SignupViewModel extends BaseViewModel {
  final _snackbarService = locator<SnackbarService>();
  void press() {
_snackbarService.showSnackbar(
  message: 'This is a snack bar',
  title: 'The title',
  duration: Duration(seconds: 2),
  onTap: (_) {
    print('snackbar tapped');
  },
  mainButtonTitle: 'Undo',
  onMainButtonTapped: () => print('Undo the action!'),
);  }
}
