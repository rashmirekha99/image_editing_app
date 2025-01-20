import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editing_app/core/utils/permission.dart';
import 'package:image_editing_app/models/text_data_model.dart';
import 'package:image_editing_app/widgets/dialog_button.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class ImageEditViewModel extends ChangeNotifier {
  final TextEditingController _textEditingController = TextEditingController();
  final ScreenshotController _screenshotController = ScreenshotController();
  List<TextData> _textData = [];
  int _currentIndex = 0;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int get currentIndex => _currentIndex;
  List<TextData> get textData => _textData;
  ScreenshotController get screenshotController => _screenshotController;

  saveToGallery(BuildContext context) {
    if (textData.isNotEmpty) {
      _screenshotController.capture().then((Uint8List? image) async {
        await saveImage(image!, context);
      }).catchError((e) => print(e));
    }
  }

  Future<void> saveImage(Uint8List image, context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final time = DateTime.now()
          .toIso8601String()
          .replaceAll('.', '-')
          .replaceAll(':', '-');
      final name = "screenshot_$time";
      final permissionRes = await requestPermission(Permission.storage);
      if (permissionRes) {
        final res = await ImageGallerySaver.saveImage(image, name: name);
        if (res['isSuccess']) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Added to Gallery')));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Error Occured')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('You don\'t have permission to access gallery')));
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print((e.toString()));
    }
  }

  void setCurrentIndex(int index) {
    print(index);
    _currentIndex = index;
    notifyListeners();
  }

  void changeTextColor(Color color) {
    _textData[_currentIndex].textColor = color;
    notifyListeners();
  }

  void increaseFontSize() {
    _textData[_currentIndex].fontSize++;
    notifyListeners();
  }

  void decreaseFontSize() {
    _textData[_currentIndex].fontSize--;
    notifyListeners();
  }

  void boldText() {
    _textData[_currentIndex].isBold = !_textData[_currentIndex].isBold;
    notifyListeners();
  }

  void underlyingText() {
    _textData[_currentIndex].isUnderlined =
        !_textData[_currentIndex].isUnderlined;
    notifyListeners();
  }

  void italicText() {
    _textData[_currentIndex].isItalic = !_textData[_currentIndex].isItalic;
    notifyListeners();
  }

  void leftAlign() {
    _textData[_currentIndex].textAlign = TextAlign.left;
    notifyListeners();
  }

  void rightAlign() {
    _textData[_currentIndex].textAlign = TextAlign.right;
    notifyListeners();
  }

  void justifyText() {
    _textData[_currentIndex].textAlign = TextAlign.justify;
    notifyListeners();
  }

  void centerAlign() {
    _textData[_currentIndex].textAlign = TextAlign.center;
    notifyListeners();
  }

  void changeTopAndLeft(double top, double left) {
    _textData[_currentIndex].top = top;
    _textData[_currentIndex].left = left;
    notifyListeners();
  }

  addNewText(BuildContext context) {
    _textData.add(TextData(
        text: _textEditingController.text,
        textColor: Colors.black,
        textAlign: TextAlign.left,
        fontSize: 15,
        isBold: false,
        isUnderlined: false,
        isItalic: false,
        left: 10,
        top: 10));

    _textEditingController.clear();
    Navigator.of(context).pop();
    notifyListeners();
  }

  addNewDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Add Text'),
              content: TextFormField(
                controller: _textEditingController,
              ),
              actions: [
                DialogButton(
                    onpressed: () => Navigator.of(context).pop(),
                    child: const Text('close')),
                DialogButton(
                    onpressed: () => addNewText(context),
                    child: const Text('Add')),
              ]);
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
  }
}
