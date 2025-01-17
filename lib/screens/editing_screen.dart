import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_editing_app/widgets/edit_view_model.dart';
import 'package:image_editing_app/widgets/image_text.dart';

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
        body: Builder(builder: (stackContext) {
          return Stack(
            children: [
              _image,
              for (int i = 0; i < textData.length; i++)
                Positioned(
                    left: textData[i].left,
                    top: textData[i].top,
                    child: GestureDetector(
                      onLongPress: () {},
                      onTap: () {},
                      child: Draggable(
                        feedback: ImageText(textData: textData[i]),
                        child: ImageText(textData: textData[i]),
                        onDragEnd: (details) {
                          final renderBox =
                              stackContext.findRenderObject() as RenderBox;
                          Offset offset =
                              renderBox.globalToLocal(details.offset);
                          setState(() {
                            textData[i].top = offset.dy;
                            textData[i].left = offset.dx;
                          });
                        },
                      ),
                    ))
            ],
          );
        }),
        floatingActionButton: _floatingActionButton);
  }

  Widget get _image => Image.file(
        widget.imageFile!,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      );

  Widget get _floatingActionButton => FloatingActionButton(
        onPressed: () => addNewDialog(context),
        child: const Icon(Icons.edit),
      );
}
