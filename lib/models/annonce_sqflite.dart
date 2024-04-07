import 'dart:typed_data';

import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/Utilisateur.dart';
import 'package:flutter/material.dart';

class AnnonceSQFLite {
  String? titreAnnonce;
  String? descriptionAnnonce;
  DateTime? dateAideAnnonce;
  bool estUrgente;
  double? prixAnnonce;
  List<Uint8List> images = [];
  List<String> categories = [];

  addImage(Uint8List image) {
    images.add(image);
  }

  AnnonceSQFLite({
    this.titreAnnonce,
    this.descriptionAnnonce,
    this.dateAideAnnonce,
    this.estUrgente = false,
    this.prixAnnonce,
  });

}
