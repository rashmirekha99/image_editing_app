import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant/tool_constant.dart';
import 'package:image_editing_app/view_model/image_edit_view_model.dart';
import 'package:image_editing_app/view/widgets/tool_icon.dart';
import 'package:provider/provider.dart';

class EditingTools extends StatefulWidget {
  const EditingTools({super.key});

  @override
  State<EditingTools> createState() => _EditingToolsState();
}

class _EditingToolsState extends State<EditingTools> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10, //horizontal
      runSpacing: 10, //vertical
      children: [_alignTools, _styleTools, _colorTools],
    );
  }

  Widget get _alignTools => Row(
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
              onpressed: () => context.read<ImageEditViewModel>().leftAlign()),
          ToolIcon(
              icon: Icons.format_align_right,
              onpressed: () => context.read<ImageEditViewModel>().rightAlign()),
        ],
      );

  Widget get _styleTools => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ToolIcon(
              icon: Icons.format_bold_sharp,
              onpressed: () => context.read<ImageEditViewModel>().boldText()),
          ToolIcon(
              icon: Icons.format_italic,
              onpressed: () => context.read<ImageEditViewModel>().italicText()),
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
      );

  Widget get _colorTools => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            spacing: 10,
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
        ),
      );
}
