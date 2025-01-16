import 'package:image_picker/image_picker.dart';

Future<XFile?> imagePick() async {
  final ImagePicker imagePicker = ImagePicker();
  final XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
  return file;
}
