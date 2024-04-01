import 'package:allo/main.dart';
import 'package:allo/models/DB/avis_bd.dart';
import 'package:allo/models/Utilisateur.dart';

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

  static Future<Utilisateur> getMyUser() async {
    // table utilisateur
    // idutilisateur, nomutilisateur, emailutilisateur, photoDeProfilutilisateur
    
    try {
      String? curEmail = supabase.auth.currentUser?.email;
      final response = await supabase
          .from('utilisateur')
          .select()
          .eq('emailutilisateur', curEmail);
      print('Response: $response');

      List<Utilisateur> utilisateurs = (response as List)
          .map((utilisateur) => Utilisateur.fromJson(utilisateur))
          .toList();

      Utilisateur user = utilisateurs[0];

      AvisBD.getAvisUtilisateur(user.idUtilisateur).then((value) {
        user.nbAvis = value['nbAvis'];
        user.note = value['noteMoyenne'];
      });

      return user;
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      return Utilisateur(
        idUtilisateur: '',
        nomUtilisateur: '',
        photoDeProfilUtilisateur: null,
        nbAvis: 0,
        note: 0.0,
      );
    }
  }
}