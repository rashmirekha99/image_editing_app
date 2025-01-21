import 'package:flutter/material.dart';
import 'package:image_editing_app/models/text_data_model.dart';

class ImageText extends StatelessWidget {
  const ImageText({super.key, required this.textData});
  final TextData textData;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        // decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Text(
          textAlign: textData.textAlign,
          textData.text,
          softWrap: true,
          overflow: TextOverflow.visible,
          style: TextStyle(
              fontStyle:
                  textData.isItalic ? FontStyle.italic : FontStyle.normal,
              color: textData.textColor,
              fontSize: textData.fontSize,
              fontWeight: textData.isBold ? FontWeight.bold : FontWeight.normal,
              decorationColor: textData.textColor,
              decoration: textData.isUnderlined
                  ? TextDecoration.underline
                  : TextDecoration.none),
        ),
      ),
    );
  }
}
