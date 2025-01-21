

import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({super.key, required this.onpressed, required this.child});
  final VoidCallback onpressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      child: child,
    );
  }
}
