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