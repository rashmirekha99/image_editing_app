import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant/text_constant.dart';
import 'package:image_editing_app/core/theme/app_theme.dart';
import 'package:image_editing_app/routes/route_names.dart';
import 'package:image_editing_app/routes/routes.dart';
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
          debugShowCheckedModeBanner: false,
          title: TextConstant.appTitle,
          theme: AppTheme.lightTheme,
          initialRoute: RouteNames.initialRoute,
          onGenerateRoute: onGenerateRoute,
        );
      },
    );
  }
}
