import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker imagePicker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Edit'),
      ),
      body: Center(
        child: IconButton(
            onPressed: ()async {
           final XFile? file=  await imagePicker.pickImage(source: ImageSource.gallery);
            },
            icon: Icon(Icons.image)),
      ),
    );
  }
}
