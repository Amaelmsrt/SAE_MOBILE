import 'dart:typed_data';

class Utilisateur {
  String idUtilisateur;
  String nomUtilisateur;
  String? emailUtilisateur;
  Uint8List? photoDeProfilUtilisateur;
  int nbAvis;
  double note;

  Utilisateur({
    required this.idUtilisateur,
    required this.nomUtilisateur,
    this.emailUtilisateur,
    required this.photoDeProfilUtilisateur,
    this.nbAvis = 0,
    this.note = 0.0,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      idUtilisateur: json['idutilisateur'],
      nomUtilisateur: json['nomutilisateur'],
      emailUtilisateur: json['emailutilisateur'] == null
          ? null
          : json['emailutilisateur'],
      photoDeProfilUtilisateur: json['photoDeProfilutilisateur'] == null
          ? null
          : Uint8List.fromList(json['photoDeProfilutilisateur'].codeUnits),
      nbAvis: json['nbavis'] ?? 0,
      note: json['note'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idutilisateur': idUtilisateur,
      'nomutilisateur': nomUtilisateur,
      'emailutilisateur': emailUtilisateur,
      'photoDeProfilutilisateur': photoDeProfilUtilisateur,
      'nbavis': nbAvis,
      'note': note,
    };
  }
}