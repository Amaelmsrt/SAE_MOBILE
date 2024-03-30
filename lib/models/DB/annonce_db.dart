import 'dart:convert';
import 'dart:typed_data';

import 'package:allo/models/Utilisateur.dart';
import 'package:allo/models/image_converter.dart';
import 'package:image_picker/image_picker.dart';

import '../../main.dart';
import '../annonce.dart';
import 'user_bd.dart';
import 'package:convert/convert.dart';

class AnnonceDB {
  static void ajouterAnnonce(
      List<XFile> images,
      String titreAnnonce,
      String descriptionAnnonce,
      DateTime dateAideAnnonce,
      List<String> categorieAnnonce,
      bool estUrgente) async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      final response = await supabase.from('annonce').insert([
        {
          'titreannonce': titreAnnonce,
          'descriptionannonce': descriptionAnnonce,
          'datepubliannonce': DateTime.now().toIso8601String(),
          'dateaideannonce': dateAideAnnonce.toIso8601String(),
          'esturgente': estUrgente,
          'etatannonce': 0,
          'idutilisateur': myUUID,
        }
      ]).select('idannonce');

      print('Response annonce: $response');

      // on insère dans photo_annonce
      // photo: bytea
      // idannonce: uuid

      final idAnnonce = response[0]['idannonce'];

      for (var image in images) {
        Uint8List imageBytes = await image.readAsBytes();
        // Convertir l'image en une chaîne hexadécimale
        String hexEncoded = hex.encode(imageBytes);

// Stocker l'image dans la base de données
        final responseImage = await supabase.from('photo_annonce').insert([
          {
            'photo': '\\x$hexEncoded', // Préfixer la chaîne hexadécimale par \x
            'idannonce': idAnnonce,
          }
        ]).select('photo');

// Récupérer l'image de la base de données
        String hexDecoded = responseImage[0]['photo'].toString().substring(2);

// Convertir la chaîne hexadécimale en Uint8List
        var imgdata = hex.decode(hexDecoded);

        print("test");
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'annonce: $e');
    }
  }

  static Future<List<Annonce>> fetchAllAnnonces() async {
    try {
      //String? myUUID = await UserBD.getMyUUID();
      final responseAnnonce = await supabase
          .from('annonce')
          .select('*')
          .order('idannonce', ascending: false);
      print('Response Annonce: $responseAnnonce');

      final annonces = (responseAnnonce as List).map((annonce) async {
        final responseUtilisateur = await supabase
            .from('utilisateur')
            .select('*')
            .eq('idutilisateur', annonce['idutilisateur']);
        print('Response Utilisateur: $responseUtilisateur');

        // Combine the data from 'annonce' and 'utilisateur' here
        final utilisateur = Utilisateur.fromJson(responseUtilisateur[0]);

        Annonce nouvelleAnnonce =
            Annonce.fromJson({...annonce, 'utilisateur': utilisateur});

        final photos = await supabase
            .from('photo_annonce')
            .select('photo')
            .eq('idannonce', annonce['idannonce']);

        for (var photo in photos) {
          String hexDecoded = photo['photo'].toString().substring(2);

          // Convertir la chaîne hexadécimale en Uint8List
          Uint8List imgdata = Uint8List.fromList(hex.decode(hexDecoded));

          // Ajoutez l'image à votre objet Annonce
          nouvelleAnnonce.addImage(imgdata);
        }

        return nouvelleAnnonce;
      }).toList();

      return await Future.wait(annonces);
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }

  static Future<List<Annonce>> fetchUrgentAnnonces() async {
    try {
      final responseAnnonce = await supabase
          .from('annonce')
          .select('*')
          .eq('esturgente', true)
          .order('idannonce', ascending: false);
      print('Response Annonce: $responseAnnonce');

      final annonces = (responseAnnonce as List).map((annonce) async {
        final responseUtilisateur = await supabase
            .from('utilisateur')
            .select('*')
            .eq('idutilisateur', annonce['idutilisateur']);
        print('Response Utilisateur: $responseUtilisateur');

        // Combine the data from 'annonce' and 'utilisateur' here
        final utilisateur = Utilisateur.fromJson(responseUtilisateur[0]);
        return Annonce.fromJson({...annonce, 'utilisateur': utilisateur});
      }).toList();

      return await Future.wait(annonces);
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }

  static Future<List<Annonce>> fetchLastAnnonces() async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      final responseAnnonce = await supabase
          .from('annonce')
          .select('*')
          .order('idannonce', ascending: false)
          .limit(10);
      print('Response Annonce: $responseAnnonce');

      final annonces = (responseAnnonce as List).map((annonce) async {
        final responseUtilisateur = await supabase
            .from('utilisateur')
            .select('*')
            .eq('idutilisateur', annonce['idutilisateur']);
        print('Response Utilisateur: $responseUtilisateur');

        // Combine the data from 'annonce' and 'utilisateur' here
        final utilisateur = Utilisateur.fromJson(responseUtilisateur[0]);
        return Annonce.fromJson({...annonce, 'utilisateur': utilisateur});
      }).toList();

      return await Future.wait(annonces);
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }

  static Future<List<Annonce>> fetchFirstAnnonces() async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      final responseAnnonce = await supabase
          .from('annonce')
          .select('*')
          .order('idannonce', ascending: false)
          .limit(4);
      print('Response Annonce: $responseAnnonce');

      final annonces = (responseAnnonce as List).map((annonce) async {
        final responseUtilisateur = await supabase
            .from('utilisateur')
            .select('*')
            .eq('idutilisateur', annonce['idutilisateur']);
        print('Response Utilisateur: $responseUtilisateur');

        // Combine the data from 'annonce' and 'utilisateur' here
        final utilisateur = Utilisateur.fromJson(responseUtilisateur[0]);
        return Annonce.fromJson({...annonce, 'utilisateur': utilisateur});
      }).toList();

      return await Future.wait(annonces);
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }
}
