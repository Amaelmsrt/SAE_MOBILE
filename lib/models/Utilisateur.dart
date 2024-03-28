import 'dart:typed_data';

class Utilisateur {
  String idUtilisateur;
  String nomUtilisateur;
  String emailUtilisateur;
  Uint8List photoDeProfilUtilisateur;

  Utilisateur({
    required this.idUtilisateur,
    required this.nomUtilisateur,
    required this.emailUtilisateur,
    required this.photoDeProfilUtilisateur,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      idUtilisateur: json['idutilisateur'],
      nomUtilisateur: json['nomutilisateur'],
      emailUtilisateur: json['emailutilisateur'],
      photoDeProfilUtilisateur: json['photoDeProfilutilisateur'] == null
          ? Uint8List(0)
          : Uint8List.fromList(json['photoDeProfilutilisateur'].codeUnits),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idutilisateur': idUtilisateur,
      'nomutilisateur': nomUtilisateur,
      'emailutilisateur': emailUtilisateur,
      'photoDeProfilutilisateur': photoDeProfilUtilisateur,
    };
  }
}