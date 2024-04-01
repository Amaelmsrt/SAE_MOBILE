import 'dart:typed_data';

import 'package:allo/main.dart';
import 'package:allo/models/DB/user_bd.dart';
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

  static Future<List<Objet>> getMesObjets() async {
    try {
      String? myUUID = await UserBD.getMyUUID();

      final response = await supabase
          .from('objet')
          .select('idobjet, nomobjet, descriptionobjet, statutobjet, photoobjet')
          .eq('idutilisateur', myUUID);

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
}