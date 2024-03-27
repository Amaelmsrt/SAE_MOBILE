class Avis{
  String? imagePath;
  String pseudo, commentaire, date;
  int nbEtoiles;

  Avis({
    this.imagePath,
    required this.pseudo,
    required this.commentaire,
    required this.date,
    required this.nbEtoiles,
  }); 
}