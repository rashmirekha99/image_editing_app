import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_editing_app/routes/route_names.dart';
import 'package:image_editing_app/view/pages/editing_screen.dart';
import 'package:image_editing_app/view/pages/home_page.dart';

Route<dynamic>? onGenerateRoute(RouteSettings routeSetting) {
  switch (routeSetting.name) {
    case RouteNames.initialRoute:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case RouteNames.editingScreen:
      return MaterialPageRoute(
          builder: (context) =>
              EditingScreen(imageFile: routeSetting.arguments as File));
    default:
      return MaterialPageRoute(builder: (context) => const HomePage());
  }
}
