import 'dart:typed_data';

import 'package:allo/models/annonce.dart';

class AnnonceSQFLite extends Annonce {
  List<Uint8List> images = [];
  List<String> categories = [];
  List<String>? draftCategories;
  List<Uint8List>? draftImages;

  AnnonceSQFLite({
    required String idAnnonce,
    required String titreAnnonce,
    String? descriptionAnnonce,
    DateTime? datePubliAnnonce,
    DateTime? dateAideAnnonce,
    required int estUrgente,
    int? etatAnnonce,
    double? prixAnnonce,
    bool isSaved = false,
    bool avisLaisse = false,
    this.draftImages,
    this.draftCategories,
  }) : super(
          idAnnonce: idAnnonce,
          titreAnnonce: titreAnnonce,
          descriptionAnnonce: descriptionAnnonce,
          datePubliAnnonce: datePubliAnnonce,
          dateAideAnnonce: dateAideAnnonce,
          estUrgente: estUrgente == 0 ? false : true,
          etatAnnonce: etatAnnonce,
          utilisateur: null,
          prixAnnonce: prixAnnonce,
          isSaved: isSaved,
          avisLaisse: avisLaisse,
        ) {
    if (draftImages != null) {
      images = draftImages!;
    }
    if (draftCategories != null) {
      categories = draftCategories!;
    }
  }

  static AnnonceSQFLite fromJson(Map<String, dynamic> json) {
    return AnnonceSQFLite(
      idAnnonce: json['idAnnonce'],
      titreAnnonce: json['titreAnnonce'],
      descriptionAnnonce: json['descriptionAnnonce'],
      datePubliAnnonce: DateTime.parse(json['datePubliAnnonce']),
      dateAideAnnonce: DateTime.parse(json['dateAideAnnonce']),
      estUrgente: json['estUrgente'],
      etatAnnonce: json['etatAnnonce'],
      prixAnnonce: json['prixAnnonce'],
      isSaved: json['isSaved'] == 1 ? true : false,
      avisLaisse: json['avisLaisse'] == 1 ? true : false,
    )
      ..draftImages = (json['draftImages'] as List)
          .map((item) => Uint8List.fromList(item))
          .toList()
      ..draftCategories = List<String>.from(json['draftCategories']);
  }
}
