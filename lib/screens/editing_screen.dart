import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editing_app/widgets/edit_view_model.dart';

class EditingScreen extends StatefulWidget {
  const EditingScreen({super.key, required this.imageFile});
  final File? imageFile;

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends EditViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing screen'),
      ),
      body: Image.file(
        widget.imageFile!,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewDialog(context),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
