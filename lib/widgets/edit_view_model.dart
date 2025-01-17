import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editing_app/core/utils/permission.dart';
import 'package:image_editing_app/models/text_data_model.dart';
import 'package:image_editing_app/screens/editing_screen.dart';
import 'package:image_editing_app/widgets/dialog_button.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

abstract class EditViewModel extends State<EditingScreen> {
  TextEditingController textEditingController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextData> textData = [];
  int currentIndex = 0;

  saveToGallery(BuildContext context) {
    if (textData.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) async {
        await saveImage(image!);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Added to gallery')));
      }).catchError((e) => print(e));
    }
  }

  saveImage(Uint8List image) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(image, name: name);
  }

  setCurrentIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  changeTextColor(Color color) {
    setState(() {
      textData[currentIndex].textColor = color;
    });
  }

  increaseFontSize() {
    setState(() {
      textData[currentIndex].fontSize++;
    });
  }

  decreaseFontSize() {
    setState(() {
      textData[currentIndex].fontSize--;
    });
  }

  boldText() {
    setState(() {
      textData[currentIndex].isBold = !textData[currentIndex].isBold;
    });
  }

  underlyingText() {
    setState(() {
      textData[currentIndex].isUnderlined =
          !textData[currentIndex].isUnderlined;
    });
  }

  italicText() {
    setState(() {
      textData[currentIndex].isItalic = !textData[currentIndex].isItalic;
    });
  }

  leftAlign() {
    setState(() {
      textData[currentIndex].textAlign = TextAlign.left;
    });
  }

  rightAlign() {
    setState(() {
      textData[currentIndex].textAlign = TextAlign.right;
    });
  }

  justifyText() {
    setState(() {
      textData[currentIndex].textAlign = TextAlign.justify;
    });
  }

  centerAlign() {
    setState(() {
      textData[currentIndex].textAlign = TextAlign.center;
    });
  }

  addNewText() {
    setState(() {
      textData.add(TextData(
          text: textEditingController.text,
          textColor: Colors.black,
          textAlign: TextAlign.left,
          fontSize: 20,
          isBold: false,
          isUnderlined: false,
          isItalic: false,
          left: 0,
          top: 0));
    });
    textEditingController.clear();
    Navigator.of(context).pop();
  }

  addNewDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Add Text'),
              content: TextFormField(
                controller: textEditingController,
              ),
              actions: [
                DialogButton(
                    onpressed: () => Navigator.of(context).pop(),
                    child: const Text('close')),
                DialogButton(
                    onpressed: () => addNewText(), child: const Text('Add')),
              ]);
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }
}
