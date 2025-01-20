import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant/text_constant.dart';
import 'package:image_editing_app/widgets/dialog_button.dart';

class DialogBox extends StatefulWidget {
  const DialogBox(
      {super.key,
      required this.onPressAdd,
      required this.textEditingController});
  final VoidCallback onPressAdd;
  final TextEditingController textEditingController;

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text(TextConstant.alertBoxTitle),
        content: TextFormField(
          controller: widget.textEditingController,
        ),
        actions: [
          DialogButton(
              onpressed: () => Navigator.of(context).pop(),
              child: const Text(TextConstant.alertBoxCloseText)),
          DialogButton(
              onpressed: widget.onPressAdd,
              child: const Text(TextConstant.alertBoxOkText)),
        ]);
  }
}
