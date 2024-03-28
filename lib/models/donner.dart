class Donner {
  int idUtilisateur;
  int idAvis;

  Donner({
    required this.idUtilisateur,
    required this.idAvis,
  });

  factory Donner.fromJson(Map<String, dynamic> json) {
    return Donner(
      idUtilisateur: json['idutilisateur'],
      idAvis: json['idavis'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idutilisateur': idUtilisateur,
      'idavis': idAvis,
    };
  }
}