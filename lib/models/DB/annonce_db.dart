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

        // on ne connait que le nom(nomcat) de chaque categorie on doit faire l'association avec l'idcat
        // puis ajouter dans la tablea categoriser_annonce les idcat et idannonce

        for (var categorie in categorieAnnonce) {
          final responseCategorie = await supabase
              .from('categorie')
              .select('idcat')
              .eq('nomcat', categorie);

          final idCategorie = responseCategorie[0]['idcat'];

          final responseCategoriserAnnonce =
              await supabase.from('categoriser_annonce').insert([
            {'idcat': idCategorie, 'idannonce': idAnnonce}
          ]).select('idcat');
        }

        print("finito");
      }
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'annonce: $e');
    }
  }

  static Future<Annonce> _createAnnonceFromResponse(Map<String, dynamic> annonceData) async {
    Annonce annonce = Annonce.fromJson({...annonceData});

    final photos = await supabase
        .from("photo_annonce")
        .select('photo')
        .eq('idannonce', annonceData['idannonce']);

    for (var photo in photos) {
      String hexDecoded = photo['photo'].toString().substring(2);
      Uint8List imgdata = Uint8List.fromList(hex.decode(hexDecoded));
      annonce.addImage(imgdata);
    }

    String? myUUID = await UserBD.getMyUUID();
    final responseEnregistrer = await supabase
        .from("enregistrer")
        .select('*')
        .eq('idutilisateur', myUUID)
        .eq('idannonce', annonceData['idannonce']);

    if (responseEnregistrer.length > 0) {
      annonce.isSaved = true;
    }

    return annonce;
  }

  static Future<List<Annonce>> fetchAllAnnonces() async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      final responseAnnonce = await supabase
          .from('annonce')
          .select('*')
          .order('idannonce', ascending: false);
      print('Response Annonce: $responseAnnonce');

      final annonces = (responseAnnonce as List).map((annonce) async {
        Annonce nouvelleAnnonce = Annonce.fromJson({...annonce});

        nouvelleAnnonce = await _createAnnonceFromResponse(annonce);

        return nouvelleAnnonce;
      }).toList();

      return await Future.wait(annonces);
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }

  static Future<Annonce> fetchAnnonceDetails(String uuidAnnonce) async {
    // permet de get la description, la date de publication et l'utilisateur de l'annonce
    final responseAnnonce =
        await supabase.from('annonce').select('*').eq('idannonce', uuidAnnonce);

    final annonce = responseAnnonce as List;

    final responseUtilisateur = await supabase
        .from('utilisateur')
        .select('*')
        .eq('idutilisateur', annonce[0]['idutilisateur']) as List;

    final utilisateur = Utilisateur.fromJson(responseUtilisateur[0]);

    Annonce annonceObj =
        Annonce.fromJson({...annonce[0], 'utilisateur': utilisateur});

    // on va get les categories de l'annonce

    final responseCategories = await supabase
        .from('categoriser_annonce')
        .select('idcat')
        .eq('idannonce', uuidAnnonce) as List;

    for (var categorie in responseCategories) {
      final responseCategorie = await supabase
          .from('categorie')
          .select('nomcat')
          .eq('idcat', categorie['idcat']) as List;

      annonceObj.categories.add(responseCategorie[0]['nomcat']);
    }

    return annonceObj;
  }

  static void toggleSaveAnnonce(String idAnnonce) async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      final response = await supabase
          .from('enregistrer')
          .select()
          .eq('idutilisateur', myUUID)
          .eq('idannonce', idAnnonce)
          .maybeSingle();

      if (response != null) {
        // L'annonce est déjà enregistrée, la supprimer
        await supabase
            .from('enregistrer')
            .delete()
            .eq('idutilisateur', myUUID)
            .eq('idannonce', idAnnonce);
      } else {
        // L'annonce n'est pas enregistrée, l'ajouter
        await supabase.from('enregistrer').insert([
          {
            'idutilisateur': myUUID,
            'idannonce': idAnnonce,
          }
        ]);
      }
    } catch (e) {
      print(
          'Erreur lors de la modification de l\'enregistrement de l\'annonce: $e');
    }
  }

  static Future<List<Annonce>> fetchUrgentAnnonces() async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      final responseAnnonce = await supabase
          .from('annonce')
          .select('*')
          .eq('esturgente', true)
          .order('idannonce', ascending: false);
      print('Response Annonce: $responseAnnonce');

      final annonces = (responseAnnonce as List).map((annonce) async {
        Annonce nouvelleAnnonce = Annonce.fromJson({...annonce});

        nouvelleAnnonce = await _createAnnonceFromResponse(annonce);

        return nouvelleAnnonce;
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
          .limit(5);
      print('Response Annonce: $responseAnnonce');

      final annonces = (responseAnnonce as List).map((annonce) async {
        Annonce nouvelleAnnonce = Annonce.fromJson({...annonce});

        nouvelleAnnonce = await _createAnnonceFromResponse(annonce);

        return nouvelleAnnonce;
      }).toList();

      return await Future.wait(annonces);
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }

  static Future<List<Annonce>> fetchAnnoncesEnregistrees() async {
    try {
      String? myUUID = await UserBD.getMyUUID();

      // Récupérer les idannonce de la table enregistrer pour l'utilisateur actuel
      final responseEnregistrer = await supabase
          .from('enregistrer')
          .select('idannonce')
          .eq('idutilisateur', myUUID);


      List<String> idAnnonces = [];

      responseEnregistrer.forEach((element) {
        idAnnonces.add(element['idannonce'].toString());
      });

      // Récupérer les annonces correspondantes
      final responseAnnonce = await supabase
          .from('annonce')
          .select('*')
          .in_('idannonce', idAnnonces)
          .order('idannonce', ascending: false);

      print('Response Annonce: $responseAnnonce');

      final annonces = (responseAnnonce as List).map((annonce) async {
        Annonce nouvelleAnnonce = Annonce.fromJson({...annonce});

         nouvelleAnnonce = await _createAnnonceFromResponse(annonce);

        return nouvelleAnnonce;
      }).toList();

      return await Future.wait(annonces);
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }
}
