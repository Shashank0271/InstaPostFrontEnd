import 'package:image_picker/image_picker.dart';

class ImageService {
  final _imagePicker = ImagePicker();

  Future<XFile?> pickImageFromGallery() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<XFile?> pickImageFromCamera() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    return image;
  }
}
