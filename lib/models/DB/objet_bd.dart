import 'dart:typed_data';

import 'package:allo/main.dart';
import 'package:allo/models/DB/user_bd.dart';
import 'package:allo/models/Utilisateur.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/objet.dart';
import 'package:convert/convert.dart';
import 'package:image_picker/image_picker.dart';

class ObjetBd {
  static Future<void> ajouterObjet(
    XFile image,
    String nomObjet,
    String descriptionObjet,
    List<String> categorieObjet,
  ) async {
    try {
      String? myUUID = await UserBD.getMyUUID();

       Uint8List imageBytes = await image.readAsBytes();
      // Convertir l'image en une chaîne hexadécimale
      String hexEncoded = hex.encode(imageBytes);

      final response = await supabase.from('objet').insert([
        {
          'nomobjet': nomObjet,
          'descriptionobjet': descriptionObjet,
          'idutilisateur': myUUID,
          'photoobjet': '\\x$hexEncoded',
        }
      ]).select('idobjet');

      print('Response objet: $response');
      final idObjet = response[0]['idobjet'];

      // on ne connait que le nom(nomcat) de chaque categorie on doit faire l'association avec l'idcat
      // puis ajouter dans la tablea categoriser_objet les idcat et idobjet

      for (var categorie in categorieObjet) {
        final responseCategorie = await supabase
            .from('categorie')
            .select('idcat')
            .eq('nomcat', categorie);

        final idCategorie = responseCategorie[0]['idcat'];

        final responseCategoriserObjet =
            await supabase.from('categoriser_objet').insert([
          {'idcat': idCategorie, 'idobjet': idObjet}
        ]).select('idcat');
      }

      print("finito");
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'objet: $e');
    }
  }

  // on va aller faire le lien avec la table aider pour trouver l'annonce qui correspond à chaque objet
  // ensuite on va regarder si l'etat de l'annonce est Annonce.CLOTUREES
  // si oui on va remettre le statut de l'objet à DISPONIBLE
  static Future<void> majStatusObjet() async {
    // on va get tous les objets de l'utilisateur qui sont reserves
    try {
      String? myUUID = await UserBD.getMyUUID();

      final response = await supabase
          .from('objet')
          .select('idobjet')
          .eq('idutilisateur', myUUID)
          .eq('statutobjet', Objet.RESERVE);

      for (var objet in response) {
        final idObjet = objet['idobjet'];

        final responseAider = await supabase
            .from('aider')
            .select('idannonce')
            .eq('idobjet', idObjet);

        for (var aider in responseAider) {
          final idAnnonce = aider['idannonce'];

          final responseAnnonce = await supabase
              .from('annonce')
              .select('etatannonce')
              .eq('idannonce', idAnnonce);

          if (responseAnnonce[0]['etatannonce'] == Annonce.CLOTUREES) {
            final responseObjet = await supabase
                .from('objet')
                .update({'statutobjet': Objet.DISPONIBLE})
                .eq('idobjet', idObjet);
          }
        }
      }
    } catch (e) {
      print('Erreur lors de la mise à jour du statut de l\'objet: $e');
    }
  }

  static Future<List<Objet>> getMesObjets({onlyDisponibles = false, onlyReserves = false}) async {
    try {
      await majStatusObjet();

      String? myUUID = await UserBD.getMyUUID();

      var query = supabase
          .from('objet')
          .select('idobjet, nomobjet, descriptionobjet, statutobjet, photoobjet')
          .eq('idutilisateur', myUUID);

      if (onlyDisponibles) {
        query = query.eq('statutobjet', Objet.DISPONIBLE);
      }

      if (onlyReserves) {
        query = query.eq('statutobjet', Objet.RESERVE);
      }

      final response = await query;

      print('Response mes objets: $response');

      List<Objet> objets = [];
      for (var objet in response) {
        String hexDecoded = objet['photoobjet'].toString().substring(2);
        Uint8List imgdata = Uint8List.fromList(hex.decode(hexDecoded));

        Objet nouvelObjet = Objet(
          idObjet: objet['idobjet'],
          nomObjet: objet['nomobjet'],
          descriptionObjet: objet['descriptionobjet'],
          statutObjet: objet['statutobjet'],
          photoObjet: imgdata,
        );

        objets.add(nouvelObjet);
      }

      return objets;
    } catch (e) {
      print('Erreur lors de la récupération des objets: $e');
      return [];
    }
  }

  static Future<Utilisateur?> getProprietaireObjet(String idObjet) async {
    try {
      final response = await supabase
          .from('objet')
          .select('idutilisateur')
          .eq('idobjet', idObjet);

      final idUtilisateur = response[0]['idutilisateur'];

      return await UserBD.getUser(idUtilisateur);
    } catch (e) {
      print('Erreur lors de la récupération du propriétaire de l\'objet: $e');
      return null;
    }
  }
}