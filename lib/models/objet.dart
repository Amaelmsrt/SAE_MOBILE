import 'dart:typed_data';

class Objet {
  int idObjet;
  String nomObjet;
  String descriptionObjet;
  int statutObjet;
  Uint8List photoObjet;

  Objet({
    required this.idObjet,
    required this.nomObjet,
    required this.descriptionObjet,
    required this.statutObjet,
    required this.photoObjet,
  });

  factory Objet.fromJson(Map<String, dynamic> json) {
    return Objet(
      idObjet: json['idObjet'],
      nomObjet: json['nomObjet'],
      descriptionObjet: json['descriptionObjet'],
      statutObjet: json['statutObjet'],
      photoObjet: json['photoObjet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idObjet': idObjet,
      'nomObjet': nomObjet,
      'descriptionObjet': descriptionObjet,
      'statutObjet': statutObjet,
      'photoObjet': photoObjet,
    };
  }
}