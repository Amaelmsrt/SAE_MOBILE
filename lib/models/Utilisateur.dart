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
      idUtilisateur: json['idUtilisateur'],
      nomUtilisateur: json['nomUtilisateur'],
      emailUtilisateur: json['emailUtilisateur'],
      mdpUtilisateur: json['mdpUtilisateur'],
      photoDeProfilUtilisateur: json['photoDeProfilUtilisateur'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUtilisateur': idUtilisateur,
      'nomUtilisateur': nomUtilisateur,
      'emailUtilisateur': emailUtilisateur,
      'mdpUtilisateur': mdpUtilisateur,
      'photoDeProfilUtilisateur': photoDeProfilUtilisateur,
    };
  }
}