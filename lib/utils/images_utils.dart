import 'package:image_picker/image_picker.dart';

import 'constants.dart';

class ImageUtils {
  static final ImagePicker _picker = ImagePicker();

  static Future<XFile?> pickImage(ImageSource source) async {
    return await _picker.pickImage(
        source: source,
        imageQuality: Constants.imageQuality,
        maxHeight: Constants.maxHeight,
        maxWidth: Constants.maxWidth);
  }
}
