class Categorie {
  int idCat;
  String nomCat;

  Categorie({
    required this.idCat,
    required this.nomCat,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      idCat: json['idCat'],
      nomCat: json['nomCat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCat': idCat,
      'nomCat': nomCat,
    };
  }
}