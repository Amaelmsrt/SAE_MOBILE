import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:allo/models/Utilisateur.dart';
import 'package:allo/models/image_converter.dart';
import 'package:allo/models/objet.dart';
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
      bool estUrgente,
      double remunerationAnnonce) async {
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
          'prix_annonce': remunerationAnnonce
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

  static void modifierAnnonce(
      List<XFile> images,
      String titreAnnonce,
      String descriptionAnnonce,
      DateTime dateAideAnnonce,
      List<String> categorieAnnonce,
      bool estUrgente,
      double remunerationAnnonce,
      String idAnnonce) async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      final response = await supabase.from('annonce').update({
        'titreannonce': titreAnnonce,
        'descriptionannonce': descriptionAnnonce,
        'datepubliannonce': DateTime.now().toIso8601String(),
        'dateaideannonce': dateAideAnnonce.toIso8601String(),
        'esturgente': estUrgente,
        'etatannonce': 0,
        'idutilisateur': myUUID,
        'prix_annonce': remunerationAnnonce
      }).eq('idannonce', idAnnonce);

      print('Response annonce: $response');

      // on insère dans photo_annonce
      // photo: bytea
      // idannonce: uuid

      // on supprime les anciennes images

      final responseDelete = await supabase
          .from('photo_annonce')
          .delete()
          .eq('idannonce', idAnnonce);

      // on supprime les anciennes categories

      for (var image in images) {
        Uint8List imageBytes = await image.readAsBytes();
        // Convertir l'image en une chaîne hexadécimale
        String hexEncoded = hex.encode(imageBytes);

        // Stocker l'image dans la base de données
        final responseImage = await supabase.from('photo_annonce').upsert([
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
              await supabase.from('categoriser_annonce').upsert([
            {'idcat': idCategorie, 'idannonce': idAnnonce}
          ]).select('idcat');
        }

        print("finito");
      }
    } catch (e) {
      print('Erreur lors de la modification de l\'annonce: $e');
    }
  }

  static Future<Annonce> _createAnnonceFromResponse(
      Map<String, dynamic> annonceData) async {
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
          .select('idannonce, titreannonce, esturgente, prix_annonce')
          .not('idutilisateur', 'eq', myUUID)
          .eq('etatannonce', Annonce.EN_COURS)
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

  static Future<Annonce> fetchAnnonceDetailsWithoutUser(
      String uuidAnnonce) async {
    // permet de get la description, la date de publication et l'utilisateur de l'annonce
    final responseAnnonce =
        await supabase.from('annonce').select('*').eq('idannonce', uuidAnnonce);

    final annonce = responseAnnonce as List;

    Annonce annonceObj = Annonce.fromJson({...annonce[0]});

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

  static Future<Annonce> fetchAnnonceDetails(String uuidAnnonce) async {
    // permet de get la description, la date de publication et l'utilisateur de l'annonce
    final responseAnnonce =
        await supabase.from('annonce').select('*').eq('idannonce', uuidAnnonce);

    final annonce = responseAnnonce as List;

    final utilisateur = await UserBD.getUser(annonce[0]['idutilisateur']);

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
          .select('idannonce, titreannonce, esturgente, prix_annonce')
          .eq('esturgente', true)
          .eq('etatannonce', Annonce.EN_COURS)
          .not('idutilisateur', 'eq', myUUID)
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
          .select('idannonce, titreannonce, esturgente, prix_annonce')
          .not('idutilisateur', 'eq', myUUID)
          .eq('etatannonce', Annonce.EN_COURS)
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
          .select('idannonce, titreannonce, esturgente, prix_annonce')
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

  static Future<bool> majStatutAnnonceCloturee(String idAnnonce) async {
    try {
      final response = await supabase
          .from('annonce')
          .select('etatannonce, dateaideannonce')
          .eq('idannonce', idAnnonce);

      int etatAnnonce = response[0]['etatannonce'];
      DateTime dateAideAnnonce = DateTime.parse(response[0]['dateaideannonce']);

      if (etatAnnonce == Annonce.AIDE_PLANIFIEE &&
          dateAideAnnonce.isBefore(DateTime.now())) {
        final responseUpdate = await supabase.from('annonce').update(
            {'etatannonce': Annonce.CLOTUREES}).eq('idannonce', idAnnonce);

        print('Response update: $responseUpdate');
        return true;
      }
      print('Response annonce: $response');
    } catch (e) {
      print('Erreur lors de la mise à jour de l\'annonce: $e');
    }
    return false;
  }

  static Future<List<Annonce>> getMesAnnonces({bool forMessage = false}) async {
    // on veut juste connaitre l'image de l'annonce, le titre et son etatannonce

    try {
      String? myUUID = await UserBD.getMyUUID();
      final responseAnnonce = await supabase
          .from('annonce')
          .select(
              'idannonce, titreannonce, esturgente, prix_annonce, etatannonce, dateaideannonce')
          .eq('idutilisateur', myUUID)
          .order('idannonce', ascending: false);
      print('Response Annonce: $responseAnnonce');

      final annonces = (responseAnnonce as List).map((annonce) async {
        Annonce nouvelleAnnonce = Annonce.fromJson({...annonce});

        if (!forMessage) {
          nouvelleAnnonce = await _createAnnonceFromResponse(annonce);
        }

        // on va regarder dans la table avis si l'annonce a été notée (si idannonce est present dans la table avis)
        int etatAnnonce = annonce['etatannonce'];

        // on va vérifier si le statut de l'annonce est Aide Planifiée et que la date est passée
        bool mettreAJourCloture =
            await majStatutAnnonceCloturee(nouvelleAnnonce.idAnnonce);

        if (mettreAJourCloture) {
          nouvelleAnnonce.etatAnnonce = Annonce.CLOTUREES;
          // nouvelleAnnonce.avisLaisse = false; pas besoin de le mettre car c'est par défaut
        }

        if (etatAnnonce == Annonce.CLOTUREES) {
          final responseAvis = await supabase
              .from('avis')
              .select('idannonce')
              .eq('idannonce', nouvelleAnnonce.idAnnonce);

          if (responseAvis.length > 0) {
            nouvelleAnnonce.avisLaisse = true;
          }
        }

        return nouvelleAnnonce;
      }).toList();

      return await Future.wait(annonces);
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }

  static void aiderAnnonce(
      String idAnnonce, String idObj, String commentaire) async {
    // on ajoute dans la table aider
    // idannonce, idobjet, commentaire,

    try {
      final response = await supabase.from('aider').insert([
        {
          'idannonce': idAnnonce,
          'idobjet': idObj,
          'commentaire': commentaire,
          'estaccepte': false
        }
      ]);

      print('Response aide: $response');

      // on va mettre a jour le status dans objet

      final responseObjet = await supabase
          .from('objet')
          .update({'statutobjet': Objet.RESERVE}).eq('idobjet', idObj);
    } catch (e) {
      print('Erreur lors de l\'aide de l\'annonce: $e');
    }
  }

  static void repondreAide(
      {required String idAnnonce, required bool accepter, required String idUser}) async {
    try {

      // on va get toutes les annonces correspondant a idannonce dans la table aider

      String idObjet = "";

      final responseAider = await supabase
          .from('aider')
          .select('idobjet')
          .eq('idannonce', idAnnonce) as List;

      // on va regarder chaque element de la reponse 

      for (var aider in responseAider) {
        final responseUtilisateur = await supabase
            .from('objet')
            .select('idutilisateur')
            .eq('idobjet', aider['idobjet']) as List;

        if (responseUtilisateur[0]['idutilisateur'] == idUser) {
          idObjet = aider['idobjet'];
          break;
        }
      }

      if (idObjet.isEmpty) {
        return;
      }

      final response = await supabase
          .from('aider')
          .update({'estaccepte': accepter, 'estRepondu': true}).eq(
              'idannonce', idAnnonce).eq('idobjet', idObjet).
              select("idobjet");

      print('Response aide: $response');

      // on va aussi faire une maj de l'annonce pour changer son etatannonce
      final responseAnnonce = await supabase
          .from('annonce')
          .update({'etatannonce': accepter ? 1 : 0}).eq('idannonce', idAnnonce);

      final responseObjet = await supabase
          .from('objet')
          .update({'statutobjet': accepter ? 1 : 0}).eq('idobjet', response[0]['idobjet']);

      print('Response annonce: $responseAnnonce');
    } catch (e) {
      print('Erreur lors de la réponse à l\'aide: $e');
    }
  }

  static Future<List<String>> findAnnonces(String word) async {
    List<String> annonces = [];
    final response = await supabase
        .from('annonce')
        .select('titreannonce')
        .ilike('titreannonce', '%$word%')
        .limit(10) as List;

    for (var annonce in response) {
      annonces.add(annonce['titreannonce']);
    }

    return annonces;
  }

  static Future<Annonce> fetchAnnonceByTitle(String title) async {
    final response = await supabase
        .from('annonce')
        .select('*')
        .eq('titreannonce', title)
        .limit(1) as List;

    return _createAnnonceFromResponse(response[0]);
  }

  static Future<Annonce> getAnnonce(String idAnnonce) async {
    final response = await supabase
        .from('annonce')
        .select('*')
        .eq('idannonce', idAnnonce)
        .limit(1) as List;

    return _createAnnonceFromResponse(response[0]);
  }

  static Future<Annonce> getAnnonceWithDetails(String idAnnonce) async {
    Annonce annonce = await getAnnonce(idAnnonce);
    Annonce details = await fetchAnnonceDetailsWithoutUser(idAnnonce);

    annonce.categories = details.categories;
    annonce.dateAideAnnonce = details.dateAideAnnonce;
    annonce.descriptionAnnonce = details.descriptionAnnonce;

    return annonce;
  }

  static Future<Annonce> getAnnonceWithUser(String idAnnonce) async {
    final response = await supabase
        .from('annonce')
        .select('*')
        .eq('idannonce', idAnnonce)
        .limit(1) as List;

    Annonce annonce = await _createAnnonceFromResponse(response[0]);

    final utilisateur = await UserBD.getUser(response[0]['idutilisateur']);

    annonce.utilisateur = utilisateur;

    return annonce;
  }
}
