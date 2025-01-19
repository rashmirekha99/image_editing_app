import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant.dart';
import 'package:image_editing_app/widgets/edit_view_model.dart';
import 'package:image_editing_app/widgets/image_text.dart';
import 'package:image_editing_app/widgets/tool_icon.dart';
import 'package:screenshot/screenshot.dart';

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
          actions: [
            IconButton(
                onPressed: () => saveToGallery(context),
                icon: const Icon(Icons.save))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Builder(builder: (stackContext) {
                return Screenshot(
                  controller: screenshotController,
                  child: Stack(
                    children: [
                      _image,
                      for (int i = 0; i < textData.length; i++)
                        Positioned(
                            left: textData[i].left,
                            top: textData[i].top,
                            child: GestureDetector(
                              onLongPress: () {},
                              onTap: () => setCurrentIndex(i),
                              child: Draggable(
                                feedback: ImageText(textData: textData[i]),
                                child: ImageText(textData: textData[i]),
                                onDragEnd: (details) {
                                  final renderBox = stackContext
                                      .findRenderObject() as RenderBox;
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
                  ),
                );
              }),
              _editingTools
            ],
          ),
        ),
        floatingActionButton: _floatingActionButton);
  }

  Widget get _image => Image.file(
        widget.imageFile!,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      );

  Widget get _floatingActionButton => FloatingActionButton.extended(
        onPressed: () => addNewDialog(context),
        label: const Text('Add Text'),
      );
  Widget get _editingTools => Wrap(
        spacing: 10, //horizontal
        runSpacing: 10, //vertical
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToolIcon(
                  icon: Icons.format_align_justify,
                  onpressed: () => justifyText()),
              ToolIcon(
                  icon: Icons.format_align_center_sharp,
                  onpressed: () => centerAlign()),
              ToolIcon(
                  icon: Icons.format_align_left, onpressed: () => leftAlign()),
              ToolIcon(
                  icon: Icons.format_align_right,
                  onpressed: () => rightAlign()),
            ],
          ),

          ////

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToolIcon(
                  icon: Icons.format_bold_sharp, onpressed: () => boldText()),
              ToolIcon(
                  icon: Icons.format_italic, onpressed: () => italicText()),
              ToolIcon(
                  icon: Icons.format_underline_outlined,
                  onpressed: () => underlyingText()),
              ToolIcon(
                  icon: Icons.text_increase_outlined,
                  onpressed: () => increaseFontSize()),
              ToolIcon(
                  icon: Icons.text_decrease,
                  onpressed: () => decreaseFontSize()),
            ],
          ),

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ToolConstants.ktoolColors.map(
              (e) {
                return GestureDetector(
                  onTap: () => changeTextColor(e),
                  child: CircleAvatar(
                    backgroundColor: e,
                  ),
                );
              },
            ).toList(),
          ),
        ],
      );
}
