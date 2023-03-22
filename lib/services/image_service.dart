import 'package:image_picker/image_picker.dart';
import 'package:insta_post/app/app.logger.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';

class ImageService {
  final _bottomsheetService = locator<BottomSheetService>();
  final _imagePicker = ImagePicker();
  final _logger = getLogger('ImageService');

  Future<XFile?> pickImageFromGallery() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<XFile?> pickImageFromCamera() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    return image;
  }

  Future<XFile?> takePicture() async {
    SheetResponse sheetResponse = await _bottomsheetService.showBottomSheet(
        title: 'Select Image from',
        confirmButtonTitle: 'Camera',
        cancelButtonTitle: 'Gallery') as SheetResponse;
    if (sheetResponse.confirmed) {
      _logger.v('opening camera');
      return await pickImageFromCamera();
    } else {
      _logger.v('opening gallery');
      return await pickImageFromGallery();
    }
  }
}
