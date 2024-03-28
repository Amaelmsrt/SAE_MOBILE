import '../../main.dart';
import '../annonce.dart';

class AnnonceDB {
  static Future<List<Annonce>> fetchAllAnnonces() async {
    try {
      final response = await supabase
          .from('annonce')
          .select()
          .order('idannonce', ascending: false);
      print('Response: $response');

      final annonces = (response as List)
          .map((annonce) => Annonce.fromJson(annonce))
          .toList();

      return annonces;
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }

  static Future<List<Annonce>> fetchLastAnnonces() async {
    try {
      final response = await supabase
          .from('annonce')
          .select()
          .order('idannonce', ascending: false)
          .limit(10);
      print('Response: $response');

      final annonces = (response as List)
          .map((annonce) => Annonce.fromJson(annonce))
          .toList();

      return annonces;
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }

  static Future<List<Annonce>> fetchUrgentAnnonces() async {
    try {
      final response = await supabase
          .from('annonce')
          .select()
          .eq('esturgente', true)
          .order('idannonce', ascending: false);
      print('Response: $response');

      final annonces = (response as List)
          .map((annonce) => Annonce.fromJson(annonce))
          .toList();

      return annonces;
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }

  static Future<List<Annonce>> fetchFirstAnnonces() async {
    try {
      final response = await supabase
          .from('annonce')
          .select()
          .order('idannonce', ascending: false)
          .limit(4);

      print('Response: $response');

      final annonces = (response as List)
          .map((annonce) => Annonce.fromJson(annonce))
          .toList();

      return annonces;
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return [];
    }
  }
}