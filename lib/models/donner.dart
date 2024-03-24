class Donner {
  int idUtilisateur;
  int idAvis;

  Donner({
    required this.idUtilisateur,
    required this.idAvis,
  });

  factory Donner.fromJson(Map<String, dynamic> json) {
    return Donner(
      idUtilisateur: json['idUtilisateur'],
      idAvis: json['idAvis'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUtilisateur': idUtilisateur,
      'idAvis': idAvis,
    };
  }
}