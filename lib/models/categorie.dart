class Categorie {
  int idCat;
  String nomCat;

  Categorie({
    required this.idCat,
    required this.nomCat,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      idCat: json['idcat'],
      nomCat: json['nomcat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idcat': idCat,
      'nomcat': nomCat,
    };
  }
}