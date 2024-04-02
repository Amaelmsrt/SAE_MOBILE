import 'package:allo/main.dart';

class AvisBD{
  static Future<Map<String, dynamic>> getAvisUtilisateur(String idUtilisateur) async {
    final response = await supabase
        .from('avis')
        .select()
        .eq('idutilisateur_dest', idUtilisateur);
    
    int nbAvis = 0;
    double noteMoyenne = 0.0;

    for (var avis in response) {
      nbAvis++;             
      noteMoyenne += avis['noteavis'];
    }

    if (nbAvis > 0) {
      noteMoyenne /= nbAvis;
    }

    return {
      'nbAvis': nbAvis,
      'noteMoyenne': noteMoyenne,
    };
  }

  static void ajouterAvisAnnonce(String idAnnonce, String idUtilisateur, String titreAvis, String commentaireAvis, int noteAvis) async{
    // on doit mettre à jour la table avis
    // titreavis, noteavis, messageavis, idutilisateur_dest, idannonce, idutilisateur_dest (qui vaudra idutilisateur)

    try {
      final response = await supabase.from('avis').insert([
        {
          'titreavis': titreAvis,
          'noteavis': noteAvis,
          'messageavis': commentaireAvis,
          'idutilisateur_dest': idUtilisateur,
          'idannonce': idAnnonce,
        }
      ]);

      print('Response avis: $response');
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'avis: $e');
    }
  }
}