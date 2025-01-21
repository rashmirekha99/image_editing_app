import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant/app_images.dart';
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
        title: const Text(TextConstant.mainPageTitle),
      ),
      body: Center(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.2),
          child: Column(
            children: [
              Image.asset(
                AppImages.homePageImage,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final File? file = await imagePick();
                      if (file != null) {
                        Navigator.pushNamed(context, RouteNames.editingScreen,
                            arguments: file);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 50),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1, 5),
                                blurRadius: 10)
                          ],
                          color: Colors.grey[200],
                          border: Border.all(width: 2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.add_photo_alternate_rounded,
                            size: 50,
                          ),
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(TextConstant.homePageAddImageTitle),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
