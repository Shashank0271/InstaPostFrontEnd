import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_post/models/Post.dart';
import 'package:insta_post/services/image_service.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';

class EditPostViewModel extends BaseViewModel {
  final _imageService = locator<ImageService>();

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

  final _logger = getLogger('EditPostViewModel');
  void updatePost({String? name}) {}

  Future takePicture() async {
    selectedFile = await _imageService.takePicture();
    notifyListeners();
  }

  onChanged(value) {
    selectedCategory = value.name as String;
    notifyListeners();
  }

  initValues(Post post) {
    titleController.text = post.title;
    bodyController.text = post.body;
    selectedCategory = post.category;
  }

  @override
  void dispose() {
    super.dispose();
    singleValueDropDownController.dispose();
    titleController.dispose();
    bodyController.dispose();
  }
}
