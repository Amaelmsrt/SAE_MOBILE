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
      idReponse: json['idreponse'],
      commentaireReponse: json['commentairereponse'],
      estAcceptee: json['estacceptee'],
      prix: json['prix'],
      idUtilisateur: json['idutilisateur'],
      idAnnonce: json['idannonce'],
      idObjet: json['idobjet'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idreponse': idReponse,
      'commentairereponse': commentaireReponse,
      'estacceptee': estAcceptee,
      'prix': prix,
      'idutilisateur': idUtilisateur,
      'idannonce': idAnnonce,
      'idobjet': idObjet,
    };
  }
}
