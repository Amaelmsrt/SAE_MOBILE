import 'dart:typed_data';

class Utilisateur {
  int idUtilisateur;
  String nomUtilisateur;
  String emailUtilisateur;
  String mdpUtilisateur;
  Uint8List photoDeProfilUtilisateur;

  Utilisateur({
    required this.idUtilisateur,
    required this.nomUtilisateur,
    required this.emailUtilisateur,
    required this.mdpUtilisateur,
    required this.photoDeProfilUtilisateur,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      idUtilisateur: json['idutilisateur'],
      nomUtilisateur: json['nomutilisateur'],
      emailUtilisateur: json['emailutilisateur'],
      mdpUtilisateur: json['mdputilisateur'],
      photoDeProfilUtilisateur: json['photoDeProfilutilisateur'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idutilisateur': idUtilisateur,
      'nomutilisateur': nomUtilisateur,
      'emailutilisateur': emailUtilisateur,
      'mdputilisateur': mdpUtilisateur,
      'photoDeProfilutilisateur': photoDeProfilUtilisateur,
    };
  }
}