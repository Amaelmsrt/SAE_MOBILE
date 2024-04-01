import 'package:allo/main.dart';

class CategorieDB{

  static Future<List<String>> _findCategories(String word) async {
      // je fais une requete pour recuperer les categories qui contiennent le texte 
    List<String> categories = [];
    final response = await supabase
        .from('categorie')
        .select('nomcat')
        .ilike('nomcat', '%$word%') // ne prend pas en compte la casse
        .limit(10) as List;

    for (var cat in response) {
      categories.add(cat['nomcat']);
    }

    return categories;
  }

  static Future<List<String>> findMatchingCategories({required String text, int nbToFind = -1}) async {
    List<String> categories = [];
    // on affiche si le texte n'est pas videe
    if (text.isNotEmpty) {
      // dans supabase j'ai une table categorie
      // avec nomcat: nom de la categorie
      
      // si le texte n'a qu'un mot je fais une seule requete

      if (!text.contains(' ')) {
        return await _findCategories(text);
      }

      // pour chaque mot dans le texte je fais une requete
      for (var word in text.split(' ')) {
        List<String> cats = await _findCategories(word);
        if (word.isEmpty){
          continue;
        }
        for (var cat in cats) {
          if (!categories.contains(cat)) {
            categories.add(cat);
            if ((nbToFind != -1 && categories.length >= nbToFind) || (nbToFind == -1 && categories.length >= 15)) {
              return categories;
            }
          }
        }
      }
    }
    return categories;
  }
}