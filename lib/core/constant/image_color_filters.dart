import 'dart:ui';

import 'package:flutter/material.dart';

class ImageColorFilters {
  static const List<Map<String, ColorFilter>> colorFilterList = [
    normal,
    greyscale,
    sepia,
    brighten,
    invert,
    green,
  ];

  static const Map<String, ColorFilter> green = {
    'Green': ColorFilter.mode(Colors.green, BlendMode.color)
  };
  

  static const Map<String, ColorFilter> greyscale = {
    'Greyscale': ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ])
  };
  static const Map<String, ColorFilter> brighten = {
    'Brighten': ColorFilter.matrix(<double>[
      1,
      0,
      0,
      0,
      50,
      0,
      1,
      0,
      0,
      50,
      0,
      0,
      1,
      0,
      50,
      0,
      0,
      0,
      1,
      0,
    ])
  };

  static const Map<String, ColorFilter> sepia = {
    'Sepia': ColorFilter.matrix(<double>[
      0.393,
      0.769,
      0.189,
      0,
      0,
      0.349,
      0.686,
      0.168,
      0,
      0,
      0.272,
      0.534,
      0.131,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ])
  };

  static const Map<String, ColorFilter> invert = {
    'Invert': ColorFilter.matrix(<double>[
      -1,
      0,
      0,
      0,
      255,
      0,
      -1,
      0,
      0,
      255,
      0,
      0,
      -1,
      0,
      255,
      0,
      0,
      0,
      1,
      0,
    ])
  };
  static const Map<String, ColorFilter> normal = {
    'Normal': ColorFilter.matrix(<double>[
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ])
  };
}
