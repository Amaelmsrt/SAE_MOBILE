class CategoriserObjet {
  int idObjet;
  int idAnnonce;

  CategoriserObjet({
    required this.idObjet,
    required this.idAnnonce,
  });

  factory CategoriserObjet.fromJson(Map<String, dynamic> json) {
    return CategoriserObjet(
      idObjet: json['idobjet'],
      idAnnonce: json['idannonce'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idobjet': idObjet,
      'idannonce': idAnnonce,
    };
  }
}