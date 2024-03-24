class CategoriserAnnonce {
  int idCat;
  int idAnnonce;

  CategoriserAnnonce({
    required this.idCat,
    required this.idAnnonce,
  });

  factory CategoriserAnnonce.fromJson(Map<String, dynamic> json) {
    return CategoriserAnnonce(
      idCat: json['idCat'],
      idAnnonce: json['idAnnonce'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCat': idCat,
      'idAnnonce': idAnnonce,
    };
  }
}