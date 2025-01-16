import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editing_app/screens/editing_screen.dart';
import 'package:image_editing_app/screens/home_page.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: const HomePage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const HomePage());
          case '/editing_screen':
            return MaterialPageRoute(
                builder: (context) =>
                    EditingScreen(imageFile: settings.arguments as File));
          default:
            return MaterialPageRoute(builder: (context) => const HomePage());
        }
      },
    );
  }
}
