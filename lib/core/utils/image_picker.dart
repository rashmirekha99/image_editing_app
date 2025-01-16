import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> imagePick() async {
  try {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 50);
    if (file != null) {
      return File(file.path);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
