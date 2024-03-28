import 'package:allo/main.dart';

class UserBD {
  static Future<String> getMyUUID() async {
    try {
      String? curEmail = supabase.auth.currentUser?.email;
      final response = await supabase
          .from('utilisateur')
          .select('idutilisateur')
          .eq('emailutilisateur', curEmail);
      print('Response: $response');

      List<String> id = (response as List)
          .map((utilisateur) => utilisateur['idutilisateur'] as String)
          .toList();
      return id[0];
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return '';
    }
  }
}