class Avis {
  int idAvis;
  String titreAvis;
  int noteAvis;
  String messageAvis;
  DateTime dateAvis;
  int idUtilisateur;

  Avis({
    required this.idAvis,
    required this.titreAvis,
    required this.noteAvis,
    required this.messageAvis,
    required this.dateAvis,
    required this.idUtilisateur,
  });

  factory Avis.fromJson(Map<String, dynamic> json) {
    return Avis(
      idAvis: json['idAvis'],
      titreAvis: json['titreAvis'],
      noteAvis: json['noteAvis'],
      messageAvis: json['messageAvis'],
      dateAvis: DateTime.parse(json['dateAvis']),
      idUtilisateur: json['idUtilisateur'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idAvis': idAvis,
      'titreAvis': titreAvis,
      'noteAvis': noteAvis,
      'messageAvis': messageAvis,
      'dateAvis': dateAvis.toIso8601String(),
      'idUtilisateur': idUtilisateur,
    };
  }
}