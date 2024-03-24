class CategoriserObjet {
  int idObjet;
  int idAnnonce;

  CategoriserObjet({
    required this.idObjet,
    required this.idAnnonce,
  });

  factory CategoriserObjet.fromJson(Map<String, dynamic> json) {
    return CategoriserObjet(
      idObjet: json['idObjet'],
      idAnnonce: json['idAnnonce'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idObjet': idObjet,
      'idAnnonce': idAnnonce,
    };
  }
}