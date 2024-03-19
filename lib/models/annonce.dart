class Annonce {
  String imageLink;
  int niveauUrgence;
  String titre;
  bool isSaved;
  double prix;

  Annonce({
    required this.imageLink,
    required this.niveauUrgence,
    required this.titre,
    required this.isSaved,
    required this.prix,
  });
}