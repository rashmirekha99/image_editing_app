import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editing_app/routes/route_names.dart';
import 'package:image_editing_app/core/constant/text_constant.dart';
import 'package:image_editing_app/core/utils/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextConstant.mainPageTitle),
      ),
      body: Center(
        child: IconButton(
            onPressed: () async {
              final File? file = await imagePick();
              if (file != null) {
                Navigator.pushNamed(context, RouteNames.editingScreen,
                    arguments: file);
              }
            },
            icon: const Icon(Icons.image)),
      ),
    );
  }
}
