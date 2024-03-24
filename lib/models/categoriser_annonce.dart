class CategoriserAnnonce {
  int idCat;
  int idAnnonce;

  CategoriserAnnonce({
    required this.idCat,
    required this.idAnnonce,
  });

  factory CategoriserAnnonce.fromJson(Map<String, dynamic> json) {
    return CategoriserAnnonce(
      idCat: json['idcat'],
      idAnnonce: json['idannonce'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idcat': idCat,
      'idannonce': idAnnonce,
    };
  }
}