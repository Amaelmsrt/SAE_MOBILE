import 'dart:typed_data';

class PhotoAnnonce {
  int idPhotoAnnonce;
  Uint8List photo;
  int idAnnonce;

  PhotoAnnonce({
    required this.idPhotoAnnonce,
    required this.photo,
    required this.idAnnonce,
  });

  factory PhotoAnnonce.fromJson(Map<String, dynamic> json) {
    return PhotoAnnonce(
      idPhotoAnnonce: json['idphotoannonce'],
      photo: json['photo'],
      idAnnonce: json['idannonce'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idphotoannonce': idPhotoAnnonce,
      'photo': photo,
      'idannonce': idAnnonce,
    };
  }
}