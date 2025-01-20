import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant/text_constant.dart';
import 'package:image_editing_app/core/constant/tool_constant.dart';
import 'package:image_editing_app/view_model/image_edit_view_model.dart';
import 'package:image_editing_app/widgets/dialog_box.dart';
import 'package:image_editing_app/widgets/image_text.dart';
import 'package:image_editing_app/widgets/tool_icon.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class EditingScreen extends StatefulWidget {
  const EditingScreen({super.key, required this.imageFile});
  final File? imageFile;

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(TextConstant.editingPageTitle),
          actions: [
            IconButton(
                onPressed: () =>
                    context.read<ImageEditViewModel>().saveToGallery(context),
                icon: const Icon(Icons.save))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Builder(builder: (stackContext) {
                return Consumer<ImageEditViewModel>(
                    builder: (context, value, child) {
                  return Screenshot(
                    controller: value.screenshotController,
                    child: Stack(
                      children: [
                        _image,
                        for (int i = 0; i < value.textData.length; i++)
                          Positioned(
                              left: value.textData[i].left,
                              top: value.textData[i].top,
                              child: GestureDetector(
                                onLongPress: () {},
                                onTap: () => value.setCurrentIndex(i),
                                child: Draggable(
                                  feedback:
                                      ImageText(textData: value.textData[i]),
                                  child: ImageText(textData: value.textData[i]),
                                  onDragEnd: (details) {
                                    final renderBox = stackContext
                                        .findRenderObject() as RenderBox;
                                    Offset offset =
                                        renderBox.globalToLocal(details.offset);

                                    value.changeTopAndLeft(
                                        offset.dy, offset.dx);
                                  },
                                ),
                              )),
                        context.read<ImageEditViewModel>().isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : const SizedBox(),
                      ],
                    ),
                  );
                });
              }),
              _editingTools
            ],
          ),
        ),
        floatingActionButton: _floatingActionButton(context));
  }

  Widget get _image => Image.file(
        widget.imageFile!,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width,
      );
  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
                onPressAdd: () {
                  context
                      .read<ImageEditViewModel>()
                      .addNewText(_textEditingController.text);

                  Navigator.of(context).pop();
                  _textEditingController.clear();
                },
                textEditingController: _textEditingController);
          }),
      label: const Text(TextConstant.alertBoxTitle),
    );
  }

  Widget get _editingTools => Wrap(
        spacing: 10, //horizontal
        runSpacing: 10, //vertical
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToolIcon(
                  icon: Icons.format_align_justify,
                  onpressed: () =>
                      context.read<ImageEditViewModel>().justifyText()),
              ToolIcon(
                  icon: Icons.format_align_center_sharp,
                  onpressed: () =>
                      context.read<ImageEditViewModel>().centerAlign()),
              ToolIcon(
                  icon: Icons.format_align_left,
                  onpressed: () =>
                      context.read<ImageEditViewModel>().leftAlign()),
              ToolIcon(
                  icon: Icons.format_align_right,
                  onpressed: () =>
                      context.read<ImageEditViewModel>().rightAlign()),
            ],
          ),

          ////

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToolIcon(
                  icon: Icons.format_bold_sharp,
                  onpressed: () =>
                      context.read<ImageEditViewModel>().boldText()),
              ToolIcon(
                  icon: Icons.format_italic,
                  onpressed: () =>
                      context.read<ImageEditViewModel>().italicText()),
              ToolIcon(
                  icon: Icons.format_underline_outlined,
                  onpressed: () =>
                      context.read<ImageEditViewModel>().underlyingText()),
              ToolIcon(
                  icon: Icons.text_increase_outlined,
                  onpressed: () =>
                      context.read<ImageEditViewModel>().increaseFontSize()),
              ToolIcon(
                  icon: Icons.text_decrease,
                  onpressed: () =>
                      context.read<ImageEditViewModel>().decreaseFontSize()),
            ],
          ),

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ToolConstants.ktoolColors.map(
              (e) {
                return GestureDetector(
                  onTap: () =>
                      context.read<ImageEditViewModel>().changeTextColor(e),
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
