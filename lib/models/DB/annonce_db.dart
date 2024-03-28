import 'package:allo/models/Utilisateur.dart';

import '../../main.dart';
import '../annonce.dart';
import 'user_bd.dart';

class AnnonceDB {
  static Future<List<Annonce>> fetchAllAnnonces() async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      final responseAnnonce = await supabase
          .from('annonce')
          .select('*')
          .order('idannonce', ascending: false);
      print('Response Annonce: $responseAnnonce');

   final annonces = (responseAnnonce as List)
    .map((annonce) async {
      final responseUtilisateur = await supabase
          .from('utilisateur')
          .select('*')
          .eq('idutilisateur', annonce['idutilisateur']);
      print('Response Utilisateur: $responseUtilisateur');

      // Combine the data from 'annonce' and 'utilisateur' here
      final utilisateur = Utilisateur.fromJson(responseUtilisateur[0]);
      return Annonce.fromJson({...annonce, 'utilisateur': utilisateur});
    })
    .toList();

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

   final annonces = (responseAnnonce as List)
    .map((annonce) async {
      final responseUtilisateur = await supabase
          .from('utilisateur')
          .select('*')
          .eq('idutilisateur', annonce['idutilisateur']);
      print('Response Utilisateur: $responseUtilisateur');

      // Combine the data from 'annonce' and 'utilisateur' here
      final utilisateur = Utilisateur.fromJson(responseUtilisateur[0]);
      return Annonce.fromJson({...annonce, 'utilisateur': utilisateur});
    })
    .toList();

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

   final annonces = (responseAnnonce as List)
    .map((annonce) async {
      final responseUtilisateur = await supabase
          .from('utilisateur')
          .select('*')
          .eq('idutilisateur', annonce['idutilisateur']);
      print('Response Utilisateur: $responseUtilisateur');

      // Combine the data from 'annonce' and 'utilisateur' here
      final utilisateur = Utilisateur.fromJson(responseUtilisateur[0]);
      return Annonce.fromJson({...annonce, 'utilisateur': utilisateur});
    })
    .toList();

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

   final annonces = (responseAnnonce as List)
    .map((annonce) async {
      final responseUtilisateur = await supabase
          .from('utilisateur')
          .select('*')
          .eq('idutilisateur', annonce['idutilisateur']);
      print('Response Utilisateur: $responseUtilisateur');

      // Combine the data from 'annonce' and 'utilisateur' here
      final utilisateur = Utilisateur.fromJson(responseUtilisateur[0]);
      return Annonce.fromJson({...annonce, 'utilisateur': utilisateur});
    })
    .toList();

      return await Future.wait(annonces);
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }
}