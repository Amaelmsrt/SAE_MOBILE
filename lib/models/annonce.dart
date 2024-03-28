import 'package:allo/models/Utilisateur.dart';

class Annonce {
  int idAnnonce;
  String titreAnnonce;
  String descriptionAnnonce;
  DateTime datePubliAnnonce;
  DateTime dateAideAnnonce;
  bool estUrgente;
  int etatAnnonce;
  Utilisateur? utilisateur;
  double? prixAnnonce;
  bool isSaved;

  Annonce({
    required this.idAnnonce,
    required this.titreAnnonce,
    required this.descriptionAnnonce,
    required this.datePubliAnnonce,
    required this.dateAideAnnonce,
    required this.estUrgente,
    required this.etatAnnonce,
    required this.utilisateur,
    this.isSaved = false,
  });

  factory Annonce.fromJson(Map<String, dynamic> json) {
    return Annonce(
      idAnnonce: json['idannonce'],
      titreAnnonce: json['titreannonce'],
      descriptionAnnonce: json['descriptionannonce'],
      datePubliAnnonce: DateTime.parse(json['datepubliannonce']),
      dateAideAnnonce: DateTime.parse(json['dateaideannonce']),
      estUrgente: json['esturgente'],
      etatAnnonce: json['etatannonce'],
      utilisateur: Utilisateur.fromJson(json['utilisateur']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idAnnonce': idAnnonce,
      'titreAnnonce': titreAnnonce,
      'descriptionAnnonce': descriptionAnnonce,
      'datePubliAnnonce': datePubliAnnonce.toIso8601String(),
      'dateAideAnnonce': dateAideAnnonce.toIso8601String(),
      'estUrgente': estUrgente,
      'etatAnnonce': etatAnnonce,
      'utilisateur': utilisateur,
    };
  }

  
}
