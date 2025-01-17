import 'dart:ui';

class TextData {
  String text;
  Color textColor;
  TextAlign textAlign;
  double fontSize;
  double top;
  double left;
  bool isBold;
  bool isUnderlined;
  bool isItalic;

  TextData(
      {required this.text,
      required this.textColor,
      required this.textAlign,
      required this.fontSize,
      required this.left,
      required this.top,
      required this.isBold,
      required this.isUnderlined,
      required this.isItalic});
}
