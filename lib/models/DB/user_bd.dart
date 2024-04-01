import 'dart:typed_data';

import 'package:allo/main.dart';
import 'package:allo/models/DB/avis_bd.dart';
import 'package:allo/models/Utilisateur.dart';
import 'package:convert/convert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserBD {

  static Future<void> updateUser(String nom, String email, String password, XFile? photo) async {
    try {
      String myUUID = await getMyUUID();
      String hexEncodedImage = '';
      if (photo != null){
        try {
          Uint8List imageBytes = await photo.readAsBytes();
          hexEncodedImage = hex.encode(imageBytes);
        } catch (e) {
          print('Erreur lors de la conversion de l\'image en bytes: $e');
        }
      } 
      final response = await supabase.from('utilisateur').update({
        if (nom.isNotEmpty) 'nomutilisateur': nom,
        if (email.isNotEmpty) 'emailutilisateur': email,
        if (photo != null) 'photodeprofilutilisateur': '\\x$hexEncodedImage',
      }).eq('idutilisateur', myUUID);
      print('Response: $response');

      // met à jour le mot de passe 
      if (password.isNotEmpty){
        final response = await supabase.auth.updateUser(
          UserAttributes(password: password),
        );
      }
    } catch (e) {
      print('Erreur lors de la mise à jour de l\'utilisateur: $e');
    }
  }

  static Future<AuthResponse> authentifyUser(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    print('Response: $response');
    return response;
  }

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

  static Future<Utilisateur> getUser(String idUtilisateur) async {
    try {
      final response = await supabase
          .from('utilisateur')
          .select()
          .eq('idutilisateur', idUtilisateur);
      print('Response: $response');

      List<Utilisateur> utilisateurs = (response as List)
          .map((utilisateur) => Utilisateur.fromJson(utilisateur))
          .toList();

      Utilisateur user = utilisateurs[0];
      
      try{
        String photo = response[0]['photodeprofilutilisateur'];
        String hexDecoded = photo.substring(2);
        Uint8List imgdata = Uint8List.fromList(hex.decode(hexDecoded));
        user.photoDeProfilUtilisateur = imgdata;
      }
      catch(e){
        print('Erreur lors de la recuperation de la photo de profil: $e');
      }

      AvisBD.getAvisUtilisateur(user.idUtilisateur).then((value) {
        user.nbAvis = value['nbAvis'];
        user.note = value['noteMoyenne'];
      });

      return user;
    } catch (e) {
      print('Erreur lors de la recuperation de l utilisateur: $e');
      return Utilisateur(
        idUtilisateur: '',
        nomUtilisateur: '',
        photoDeProfilUtilisateur: null,
        nbAvis: 0,
        note: 0.0,
      );
    }
  }

  static Future<Utilisateur> getMyUser() async {
    String myUUID = await getMyUUID();
    return getUser(myUUID);
  }
}