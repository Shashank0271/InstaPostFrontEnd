import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_post/app/app.locator.dart';
import 'package:insta_post/services/dio_service.dart';
import 'package:insta_post/services/image_service.dart';
import 'package:insta_post/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../services/authentication_service.dart';

class CreatePostViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();
  final _dioService = locator<DioService>();
  final _bottomsheetService = locator<BottomSheetService>();
  final _snackbarService = locator<SnackbarService>();
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _logger = getLogger('CreatePostViewModel');

  XFile? selectedFile;
  String? selectedCategory;
  SingleValueDropDownController singleValueDropDownController =
      SingleValueDropDownController();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  final dropDownCategoryList = const [
    DropDownValueModel(name: 'Web Dev', value: 1),
    DropDownValueModel(name: 'App dev', value: 2),
    DropDownValueModel(name: 'Sports', value: 3),
    DropDownValueModel(name: 'Movies', value: 4),
    DropDownValueModel(name: 'Games', value: 4),
    DropDownValueModel(name: 'Hardware', value: 4),
    DropDownValueModel(name: 'Anime', value: 4),
    DropDownValueModel(name: 'Life', value: 4),
  ];

  savePost() async {
    if (selectedFile == null ||
        titleController.text.isEmpty ||
        bodyController.text.isEmpty ||
        selectedCategory == null) {
      _snackbarService.showSnackbar(message: 'please enter all details');
      return;
    }

    setBusy(true);
    try {
      final currentPost = await _dioService.createPost(
          postImage: selectedFile!,
          title: titleController.text.toString().trim(),
          body: bodyController.text.toString().trim(),
          category: selectedCategory!,
          userFirebaseId: _authenticationService.firebaseUser!.uid,
          userName: _userService.currentUser!.username);

      _snackbarService.showSnackbar(
        message: 'post added successfully !',
        mainButtonTitle: 'View Post',
        onMainButtonTapped: () {
          _navigationService.navigateTo(Routes.postDetailsView,
              arguments: PostDetailsViewArguments(currentPost: currentPost!));
        },
      );
      setBusy(false);
    } catch (e) {
      _snackbarService.showSnackbar(message: e.toString());
      setBusy(false);
    }
  }

  onChanged(value) {
    selectedCategory = value.name as String;
    notifyListeners();
  }

  talePicture() async {
    SheetResponse sheetResponse = await _bottomsheetService.showBottomSheet(
        title: 'Select Image from',
        confirmButtonTitle: 'Camera',
        cancelButtonTitle: 'Gallery') as SheetResponse;
    if (sheetResponse.confirmed) {
      _logger.v('opening camera');
      selectedFile = await _imageService.pickImageFromCamera();
    } else {
      _logger.v('opening gallery');
      selectedFile = await _imageService.pickImageFromGallery();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    singleValueDropDownController.dispose();
    titleController.dispose();
    bodyController.dispose();
  }
}
