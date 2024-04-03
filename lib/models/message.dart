import 'package:allo/models/DB/annonce_db.dart';
import 'package:allo/models/DB/user_bd.dart';
import 'package:allo/models/Utilisateur.dart';
import 'package:allo/models/annonce.dart';

class Message{
  static const int DEFAULT = 0;
  static const int AVIS = 1;
  static const int AIDE = 2; 

  final int typeMessage;
  final DateTime dateMessage;
  final String contenu;
  Utilisateur? utilisateurEnvoyeur;
  Utilisateur? utilisateurReceveur;
  Annonce? annonceConcernee;
  bool estVu;
  bool isMine;

  bool estAccepte; // dans le cas d'une demande d'aide
  bool estRepondu; // dans le cas d'une demande d'aide

  Message({
    required this.typeMessage,
    required this.dateMessage,
    required this.contenu,
    this.estVu = false,
    this.utilisateurEnvoyeur,
    this.annonceConcernee,
    this.estAccepte = false,
    this.isMine = false,
    this.estRepondu = false
  });

  factory Message.fromDefaultJson(Map<String, dynamic> json){
    return Message(
      typeMessage: DEFAULT,
      dateMessage: DateTime.parse(json['date_message']),
      contenu: json['contenu'],
      estVu: json['estvu']
    );
  }
  
  factory Message.fromAideJson(Map<String, dynamic> json){
    return Message(
      typeMessage: AIDE,
      estAccepte: json['estaccepte'],
      estRepondu: json['estRepondu'],
      dateMessage: DateTime.parse(json['date_aide']),
      contenu: json['commentaire'],
    );
  }
}