import 'package:flutter/material.dart';
import 'package:image_editing_app/models/text_data_model.dart';
import 'package:image_editing_app/screens/editing_screen.dart';
import 'package:image_editing_app/widgets/dialog_button.dart';

abstract class EditViewModel extends State<EditingScreen> {
  TextEditingController textEditingController = TextEditingController();
  List<TextData> textData = [];
  int currentIndex = 0;

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

  addNewText() {
    setState(() {
      textData.add(TextData(
          text: textEditingController.text,
          textColor: Colors.black,
          textAlign: TextAlign.left,
          fontSize: 20,
          left: 0,
          top: 0));
    });
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
