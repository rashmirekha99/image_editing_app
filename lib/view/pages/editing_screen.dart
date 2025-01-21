import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant/text_constant.dart';
import 'package:image_editing_app/core/utils/image_cropper.dart';
import 'package:image_editing_app/view/lists/color_filter_list_view.dart';
import 'package:image_editing_app/view/lists/editing_tools.dart';
import 'package:image_editing_app/view/widgets/dialog_box.dart';
import 'package:image_editing_app/view/widgets/image_text.dart';
import 'package:image_editing_app/view/widgets/tool_icon.dart';
import 'package:image_editing_app/view_model/image_edit_view_model.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

// ignore: must_be_immutable
class EditingScreen extends StatefulWidget {
  EditingScreen({super.key, required this.imageFile});
  File? imageFile;

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
                icon: const Icon(
                  Icons.save,
                  color: Colors.black,
                ))
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
              const EditingTools(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _imageCrop,
                  ToolIcon(
                      icon: Icons.water_drop_sharp,
                      onpressed: () {
                        context.read<ImageEditViewModel>().setImageBlur();
                      }),
                ],
              ),
              ColorFilterListView(imageFile: widget.imageFile)
            ],
          ),
        ),
        floatingActionButton: _floatingActionButton(context));
  }

  Widget get _imageCrop => SizedBox(
        child: ToolIcon(
            icon: Icons.crop,
            onpressed: () async {
              final res = await cropImage(widget.imageFile);
              if (res != null) {
                setState(() {
                  widget.imageFile = res;
                });
              }
            }),
      );
  Widget get _image => Stack(
        children: [
          ColorFiltered(
            colorFilter: context.watch<ImageEditViewModel>().colorFilter,
            child: Image.file(
              widget.imageFile!,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Visibility(
            visible: context.watch<ImageEditViewModel>().isBlur,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
              child: Container(),
            ),
          )
        ],
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
}
