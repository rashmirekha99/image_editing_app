import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant/image_color_filters.dart';
import 'package:image_editing_app/core/constant/text_constant.dart';
import 'package:image_editing_app/core/utils/image_cropper.dart';
import 'package:image_editing_app/view_model/image_edit_view_model.dart';
import 'package:image_editing_app/widgets/dialog_box.dart';
import 'package:image_editing_app/widgets/editing_tools.dart';
import 'package:image_editing_app/widgets/image_text.dart';
import 'package:image_editing_app/widgets/tool_icon.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

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
    final height = MediaQuery.of(context).size.height;
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
              const EditingTools(),
              _imageCrop,
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.05),
                child: Container(
                  height: double.maxFinite,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children:
                        ImageColorFilters.colorFilterList.map((colorFilter) {
                      return Column(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<ImageEditViewModel>()
                                      .imageFilter(colorFilter.values.first);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ColorFiltered(
                                    colorFilter: colorFilter.values.first,
                                    child: Image.file(
                                      widget.imageFile!,
                                      fit: BoxFit.cover,
                                      width: 90,
                                      height: 100,
                                    ),
                                  ),
                                ),
                              ),
                              Text(colorFilter.keys.first),
                            ],
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
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
  Widget get _image => ColorFiltered(
        colorFilter: context.watch<ImageEditViewModel>().colorFilter,
        child: Image.file(
          widget.imageFile!,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
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
