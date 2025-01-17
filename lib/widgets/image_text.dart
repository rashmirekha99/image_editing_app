import 'package:flutter/material.dart';
import 'package:image_editing_app/models/text_data_model.dart';

class ImageText extends StatelessWidget {
  const ImageText({super.key, required this.textData});
  final TextData textData;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        textAlign: textData.textAlign,
        textData.text,
        style: TextStyle(
          color: textData.textColor,
          fontSize: textData.fontSize,
        ),
      ),
    );
  }
}
