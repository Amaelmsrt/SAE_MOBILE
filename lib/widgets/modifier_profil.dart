import 'dart:io';
import 'dart:typed_data';

import 'package:allo/components/custom_text_field.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/user_bd.dart';
import 'package:allo/models/utilisateur.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ModifierProfil extends StatefulWidget {
  @override
  _ModifierProfilState createState() => _ModifierProfilState();
}

class _ModifierProfilState extends State<ModifierProfil> {
  XFile? newImage = null;
  TextEditingController nomUtilisateurController = TextEditingController();
  TextEditingController emailUtilisateurController = TextEditingController();
  TextEditingController nouveauMotDePasseController = TextEditingController();
  TextEditingController motDePasseActuelController = TextEditingController();

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          newImage = image;
        });
      }
    } catch (e) {
      print('Erreur lors de la sélection de l\'image : $e');
    }
  }

  void submit() {
    Utilisateur? myUser = Provider.of<MyUser>(context, listen: false).myUser;
    String nomUtilisateur = nomUtilisateurController.text.isEmpty ? myUser!.nomUtilisateur : nomUtilisateurController.text;
    String emailUtilisateur = emailUtilisateurController.text.isEmpty ? (myUser!.emailUtilisateur ?? emailUtilisateurController.text) : emailUtilisateurController.text;
    String nouveauMotDePasse = nouveauMotDePasseController.text;
    String motDePasseActuel = motDePasseActuelController.text;

    // on va essayer de s'authentifier à supabase avec l'email et le mot de passe actuel
    if (myUser!.emailUtilisateur == null){
      return;
    }
    UserBD.authentifyUser(myUser.emailUtilisateur!, motDePasseActuel).then((value) {
      print("authentifié");
      UserBD.updateUser(nomUtilisateur, emailUtilisateur, nouveauMotDePasse, newImage).then((value) {
        print("utilisateur mis à jour");
        if (emailUtilisateur.isNotEmpty){
          Provider.of<MyUser>(context, listen: false).myUser!.emailUtilisateur = emailUtilisateur;
        }
        if (nomUtilisateur.isNotEmpty){
          Provider.of<MyUser>(context, listen: false).myUser!.nomUtilisateur = nomUtilisateur;
        }
        if (newImage != null){
          newImage!.readAsBytes().then((value) {
            Provider.of<MyUser>(context, listen: false).myUser!.photoDeProfilUtilisateur = value;
          });
        }
      }).catchError((error) {
        print('Erreur lors de la mise à jour de l\'utilisateur : $error');
      });
    }).catchError((error) {
      print('Erreur lors de l\'authentification : $error');
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppBarTitle>(context, listen: false)
          .setTitle('Modifier le profil');
    });
  }

  @override
  Widget build(BuildContext context) {
    Utilisateur? myUser = Provider.of<MyUser>(context).myUser;
    return Padding(
      padding: new EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: SingleChildScrollView(
        // Add this
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Stack(
                children: [
                  if (Provider.of<MyUser>(context)
                              .myUser
                              ?.photoDeProfilUtilisateur ==
                          null &&
                      newImage == null)
                    ClipOval(
                      child: Container(
                        alignment: Alignment.center,
                        color: AppColors.lightBlue,
                        width:
                            130, // you can adjust width and height to your liking
                        height:
                            130, // you can adjust width and height to your liking
                        child: Text(
                          Provider.of<MyUser>(context)
                                  .myUser
                                  ?.nomUtilisateur[0]
                                  .toUpperCase() ??
                              "?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            fontFamily: "NeueRegrade",
                          ),
                        ),
                      ),
                    ),
                  if (Provider.of<MyUser>(context)
                              .myUser
                              ?.photoDeProfilUtilisateur !=
                          null ||
                      newImage != null)
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: newImage != null ?  DecorationImage(
                          image: FileImage(File(newImage!.path)),
                          fit: BoxFit.cover,
                        ):  DecorationImage(
                          image: MemoryImage(Provider.of<MyUser>(context).myUser!.photoDeProfilUtilisateur!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: AppColors.accent, shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/icons/img-upload.svg",
                              width: 24,
                              height: 24,
                              color: AppColors.light,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CustomTextField(
                label: "Nom d'utilisateur",
                hint: myUser?.nomUtilisateur ?? "Nom utilisateur...",
                controller: nomUtilisateurController,
                iconPath: "assets/icons/user.svg"),
            CustomTextField(
                label: "E-mail",
                hint: myUser?.emailUtilisateur ?? "E-mail...",
                controller: emailUtilisateurController,
                iconPath: "assets/icons/email.svg"),
            CustomTextField(
              label: "Nouveau mot de passe",
              hint: "Mot de passe...",
              iconPath: "assets/icons/key.svg",
              controller: nouveauMotDePasseController,
              obscureText: true,
            ),
            CustomTextField(
              label: "Mot de passe actuel",
              hint: "Mot de passe...",
              iconPath: "assets/icons/key.svg",
              controller: motDePasseActuelController,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                submit();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 60),
                elevation: 0,
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                "Enregistrer",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: "NeueRegrade",
                  color: AppColors.dark,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
