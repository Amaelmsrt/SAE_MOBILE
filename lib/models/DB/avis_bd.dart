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
      noteMoyenne += avis['note'];
    }

    if (nbAvis > 0) {
      noteMoyenne /= nbAvis;
    }

    return {
      'nbAvis': nbAvis,
      'noteMoyenne': noteMoyenne,
    };
  }
}