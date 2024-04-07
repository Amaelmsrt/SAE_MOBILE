import 'dart:typed_data';

import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/utilisateur.dart';
import 'package:flutter/material.dart';

class Annonce {
  String idAnnonce;
  String titreAnnonce;
  String? descriptionAnnonce;
  DateTime? datePubliAnnonce;
  DateTime? dateAideAnnonce;
  bool estUrgente;
  int? etatAnnonce;
  Utilisateur? utilisateur;
  double? prixAnnonce;
  bool isSaved;
  List<Uint8List> images = [];
  List<String> categories = [];
  bool avisLaisse;

  static const int EN_COURS = 0;
  static const int AIDE_PLANIFIEE = 1;
  static const int ANNULEE = 2;
  static const int CLOTUREES = 3;

  addImage(Uint8List image) {
    images.add(image);
  }

  String getEtatStr(){
    switch (etatAnnonce) {
      case EN_COURS:
        return 'En cours';
      case AIDE_PLANIFIEE:
        return 'Aide planifiée';
      case ANNULEE:
        return 'Annulée';
      case CLOTUREES:
        return 'Clôturée';
      default:
        return 'En cours';
    }
  }

  Color getEtatColor(){
    switch (etatAnnonce) {
      case EN_COURS:
        return AppColors.yellow;
      case AIDE_PLANIFIEE:
        return AppColors.primary;
      case ANNULEE:
        return AppColors.danger;
      case CLOTUREES:
        return AppColors.green;
      default:
        return AppColors.yellow;
    }
  }

  Annonce({
    required this.idAnnonce,
    required this.titreAnnonce,
    this.descriptionAnnonce,
    this.datePubliAnnonce,
    this.dateAideAnnonce,
    required this.estUrgente,
    this.etatAnnonce,
    required this.utilisateur,
    this.isSaved = false,
    this.prixAnnonce,
    this.avisLaisse = false,
  });

  factory Annonce.fromJson(Map<String, dynamic> json) {
    return Annonce(
      idAnnonce: json['idannonce'],
      titreAnnonce: json['titreannonce'],
      descriptionAnnonce: json['descriptionannonce'] ?? '',
      datePubliAnnonce: DateTime.parse(json['datepubliannonce']?? '2021-01-01T00:00:00.000Z'),
      dateAideAnnonce: DateTime.parse(json['dateaideannonce'] ?? '2021-01-01T00:00:00.000Z'),
      estUrgente: json['esturgente'],
      etatAnnonce: json['etatannonce'] ?? 0,
      utilisateur: json['utilisateur'],
      prixAnnonce: double.parse(json['prix_annonce'].toString()??'0.0'),
      //utilisateur: Utilisateur.fromJson(json['utilisateur']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idAnnonce': idAnnonce,
      'titreAnnonce': titreAnnonce,
      'descriptionAnnonce': descriptionAnnonce,
      'datePubliAnnonce': datePubliAnnonce?.toIso8601String(),
      'dateAideAnnonce': dateAideAnnonce?.toIso8601String(),
      'estUrgente': estUrgente,
      'etatAnnonce': etatAnnonce,
      'utilisateur': utilisateur,
      'prixAnnonce': prixAnnonce,
    };
  }

  
}
