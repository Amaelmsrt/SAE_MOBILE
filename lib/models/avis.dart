
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
      idAvis: json['idavis'],
      titreAvis: json['titreavis'],
      noteAvis: json['noteavis'],
      messageAvis: json['messageavis'],
      dateAvis: DateTime.parse(json['dateavis']),
      idUtilisateur: json['idutilisateur'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idavis': idAvis,
      'titreavis': titreAvis,
      'noteavis': noteAvis,
      'messageavis': messageAvis,
      'dateavis': dateAvis.toIso8601String(),
      'idutilisateur': idUtilisateur,
    };
  }
//ancienne version à adapter
class Avis{
  String? imagePath;
  String pseudo, commentaire, date;
  int nbEtoiles;

  Avis({
    this.imagePath,
    required this.pseudo,
    required this.commentaire,
    required this.date,
    required this.nbEtoiles,
  }); 
}