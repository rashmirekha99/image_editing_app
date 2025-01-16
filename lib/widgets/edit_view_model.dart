import 'package:flutter/material.dart';
import 'package:image_editing_app/screens/editing_screen.dart';
import 'package:image_editing_app/widgets/dialog_button.dart';

abstract class EditViewModel extends State<EditingScreen> {
  TextEditingController textEditingController = TextEditingController();
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
                DialogButton(onpressed: () {}, child: const Text('Add')),
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
