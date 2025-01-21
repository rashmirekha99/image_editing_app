import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editing_app/core/constant/image_color_filters.dart';
import 'package:image_editing_app/view_model/image_edit_view_model.dart';
import 'package:provider/provider.dart';

class ColorFilterListView extends StatelessWidget {
  const ColorFilterListView({
    super.key,
    required this.imageFile,
  });

  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: SizedBox(
        height: double.maxFinite,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: ImageColorFilters.colorFilterList.map((colorFilter) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ColorFiltered(
                          colorFilter: colorFilter.values.first,
                          child: Image.file(
                            imageFile!,
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
    );
  }
}
