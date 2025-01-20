import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant/image_color_filters.dart';
import 'package:image_editing_app/core/constant/text_constant.dart';
import 'package:image_editing_app/core/utils/permission.dart';
import 'package:image_editing_app/core/utils/snack_bar.dart';
import 'package:image_editing_app/models/text_data_model.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class ImageEditViewModel extends ChangeNotifier {
  final ScreenshotController _screenshotController = ScreenshotController();
  final List<TextData> _textData = [];
  int _currentIndex = 0;
  bool _isLoading = false;
  ColorFilter _colorFilter = ImageColorFilters.identity;
  ColorFilter get colorFilter => _colorFilter;
  bool get isLoading => _isLoading;
  int get currentIndex => _currentIndex;
  List<TextData> get textData => _textData;
  ScreenshotController get screenshotController => _screenshotController;

  saveToGallery(BuildContext context) {
    if (textData.isNotEmpty) {
      _screenshotController.capture().then((Uint8List? image) async {
        await saveImage(image!, context);
      }).catchError((e) {
        print(e.toString());
      });
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
          showSnackBar(context, TextConstant.saveImagePositiveText);
        } else {
          showSnackBar(context, TextConstant.saveImageErrorText);
        }
      } else {
        showSnackBar(context, TextConstant.saveImagePermissionIssueText);
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print((e.toString()));
    }
  }

  void imageFilter(ColorFilter colorFilter) {
    _colorFilter = colorFilter;
    notifyListeners();
  }

  void setCurrentIndex(int index) {
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

  void addNewText(String text) {
    _textData.add(TextData(
        text: text,
        textColor: Colors.black,
        textAlign: TextAlign.left,
        fontSize: 15,
        isBold: false,
        isUnderlined: false,
        isItalic: false,
        left: 10,
        top: 10));

    notifyListeners();
  }
}
