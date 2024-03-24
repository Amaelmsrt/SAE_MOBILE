class Reponse {
  int idReponse;
  String commentaireReponse;
  bool estAcceptee;
  int prix;
  int idUtilisateur;
  int idAnnonce;
  int idObjet;

  Reponse({
    required this.idReponse,
    required this.commentaireReponse,
    required this.estAcceptee,
    required this.prix,
    required this.idUtilisateur,
    required this.idAnnonce,
    required this.idObjet,
  });

  factory Reponse.fromJson(Map<String, dynamic> json) {
    return Reponse(
      idReponse: json['idReponse'],
      commentaireReponse: json['commentaireReponse'],
      estAcceptee: json['estAcceptee'],
      prix: json['prix'],
      idUtilisateur: json['idUtilisateur'],
      idAnnonce: json['idAnnonce'],
      idObjet: json['idObjet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idReponse': idReponse,
      'commentaireReponse': commentaireReponse,
      'estAcceptee': estAcceptee,
      'prix': prix,
      'idUtilisateur': idUtilisateur,
      'idAnnonce': idAnnonce,
      'idObjet': idObjet,
    };
  }
}
