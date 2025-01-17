import 'package:flutter/material.dart';

class ToolIcon extends StatelessWidget {
  const ToolIcon({super.key, required this.icon, required this.onpressed});
  final IconData icon;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onpressed,
      icon: Icon(icon),
    );
  }
}
