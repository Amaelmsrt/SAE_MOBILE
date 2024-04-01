
import 'dart:typed_data';
import 'dart:ui';

import 'package:allo/constants/app_colors.dart';

class Objet {
  String idObjet;
  String nomObjet;
  String descriptionObjet;
  int statutObjet;
  Uint8List photoObjet;

  static const DISPONIBLE = 0;
  static const RESERVE = 1;
  static const INDISPONIBLE = 2;

  String getStatusStr(){
    switch (statutObjet) {
      case DISPONIBLE:
        return 'Disponible';
      case RESERVE:
        return 'Réservé';
      case INDISPONIBLE:
        return 'Indisponible';
      default:
        return 'Disponible';
    }
  }

  Color getStatusColor(){
    switch (statutObjet) {
      case DISPONIBLE:
        return AppColors.green;
      case RESERVE:
        return AppColors.yellow;
      case INDISPONIBLE:
        return AppColors.danger;
      default:
        return AppColors.green;
    }
  }

  Objet({
    required this.idObjet,
    required this.nomObjet,
    required this.descriptionObjet,
    required this.statutObjet,
    required this.photoObjet,
  });

  factory Objet.fromJson(Map<String, dynamic> json) {
    return Objet(
      idObjet: json['idobjet'],
      nomObjet: json['nomobjet'],
      descriptionObjet: json['descriptionobjet'],
      statutObjet: json['statutobjet'],
      photoObjet: json['photoobjet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idobjet': idObjet,
      'nomobjet': nomObjet,
      'descriptionobjet': descriptionObjet,
      'statutobjet': statutObjet,
      'photoobjet': photoObjet,
    };
  }
}
// //ancienne version
// class Objet{
//   String imagePath;
//   String title;
//   String mainCategory;

//   Objet({required this.imagePath, required this.title, required this.mainCategory});
// }