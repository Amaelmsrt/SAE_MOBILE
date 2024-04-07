
import 'dart:typed_data';
import 'dart:ui';

import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ObjetSQFLite {
  String? nomObjet;
  String? descriptionObjet;
  Uint8List? photoObjet;
  List<String> categories = [];

  ObjetSQFLite({
    this.nomObjet,
    this.descriptionObjet,
    this.photoObjet,
  });
}
