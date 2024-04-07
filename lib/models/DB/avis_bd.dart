import 'package:allo/main.dart';
import 'package:allo/models/DB/user_bd.dart';
import 'package:allo/models/avis.dart';

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

  // permet de savoir les avis nous concernant
  static Future<List<Avis>> getMesAvis() async {
    String myUUID = await UserBD.getMyUUID();
    final response = await supabase
        .from('avis')
        .select()
        .eq('idutilisateur_dest', myUUID);

    List<Avis> mesAvis = [];

    for (var avis in response) {

      // on va get l'annonce correspondante à l'avis (avec idannonce)
      // puis on va get l'idutilisateur dans l'annonce pour get l'utilisateur

      final responseAnnonce = await supabase
          .from('annonce')
          .select()
          .eq('idannonce', avis['idannonce']);

      Avis monAvis = Avis(
        idAvis: avis['idavis'],
        titreAvis: avis['titreavis'],
        noteAvis: avis['noteavis'],
        messageAvis: avis['messageavis'],
        dateAvis: DateTime.parse(avis['dateavis']),
        utilisateur: await UserBD.getUser(responseAnnonce[0]['idutilisateur']),
      );

      mesAvis.add(monAvis);
    }

    return mesAvis;
  } 
}