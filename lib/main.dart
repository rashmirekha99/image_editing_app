import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant/route_names.dart';
import 'package:image_editing_app/core/constant/text_constant.dart';
import 'package:image_editing_app/core/theme/app_theme.dart';
import 'package:image_editing_app/screens/editing_screen.dart';
import 'package:image_editing_app/screens/home_page.dart';
import 'package:image_editing_app/view_model/image_edit_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageEditViewModel(),
      builder: (BuildContext context, child) {
        return MaterialApp(
          title: TextConstant.appTitle,
          theme: AppTheme.lightTheme,
          home: const HomePage(),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case RouteNames.initialRoute:
                return MaterialPageRoute(
                    builder: (context) => const HomePage());
              case RouteNames.editingScreen:
                return MaterialPageRoute(
                    builder: (context) =>
                        EditingScreen(imageFile: settings.arguments as File));
              default:
                return MaterialPageRoute(
                    builder: (context) => const HomePage());
            }
          },
        );
      },
    );
  }
}
