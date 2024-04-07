import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/resume_annonce.dart';
import 'package:allo/components/star_picker.dart';
import 'package:allo/components/user_preview.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/annonce_db.dart';
import 'package:allo/models/DB/avis_bd.dart';
import 'package:allo/models/DB/user_bd.dart';
import 'package:allo/models/utilisateur.dart';
import 'package:allo/models/annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AjouterAvis extends StatefulWidget {

  Annonce annonce;
  String descriptionResume;
  Function? onValider;

  AjouterAvis({required this.annonce, required this.descriptionResume, this.onValider});

  @override
  State<AjouterAvis> createState() => _AjouterAvisState();
}

class _AjouterAvisState extends State<AjouterAvis> {
  TextEditingController titreController = TextEditingController();
  TextEditingController commentaireController = TextEditingController();
  ValueNotifier<int> ratingNotifier = ValueNotifier(0);

  late Future<Utilisateur> utilisateurDest = UserBD.getUserWhoHelped(widget.annonce.idAnnonce);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 110.0),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ResumeAnnonce(image: widget.annonce.images[0], title: widget.annonce.titreAnnonce, description: widget.descriptionResume),
                        SizedBox(height: 24,),
                        FutureBuilder(future: utilisateurDest, builder: 
                          (BuildContext context, AsyncSnapshot<Utilisateur> snapshot) {
                            if(snapshot.hasData){
                              return UserPreview(utilisateur: snapshot.data!);
                            }else{
                              return Container();
                            }
                          }
                        ),
                        SizedBox(height: 24,),
                        StarPicker(ratingNotifier: ratingNotifier, label: "Niveau de satisfaction"),
                        SizedBox(height: 22,),
                        CustomTextField(
                            hint: "Votre titre...",
                            label: "Titre de l'avis",
                            controller: titreController,
                            ),
                        CustomTextField(
                            hint: "Votre commentaire...",
                            label: "Commentaire",
                            controller: commentaireController,
                            isArea: true),
                        SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 110,
                width: MediaQuery.of(context).size.width,
                color: AppColors.light,
                alignment: Alignment.center,
              ),
            ),
            Positioned(
              top: 45,
              left: 0,
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text("Laisser un avis",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "NeueRegrade",
                    )),
              ),
            ),
            Positioned(
              top: 45,
              right: 25,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 45, // same height as a FAB
                  width: 45, // same width as a FAB
                  decoration: BoxDecoration(
                    color: AppColors.primary, // same color as your FAB
                    borderRadius: BorderRadius.circular(
                        8000), // change this to your desired border radius
                  ),
                  child: Center(
                    child:
                        SvgPicture.asset("assets/icons/cross.svg"), // your icon
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: AppColors.light,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      print("Laisser un avis");
                      print("Titre: ${titreController.text}");
                      print("Commentaire: ${commentaireController.text}");
                      print("Note: ${ratingNotifier.value}");
                      utilisateurDest.then((value) {
                        print("idUtilisateur: ${value.idUtilisateur}");
                        print("pseudoUtilisateur: ${value.nomUtilisateur}");
                        AvisBD.ajouterAvisAnnonce(widget.annonce.idAnnonce, value.idUtilisateur, titreController.text, commentaireController.text, ratingNotifier.value);
                      });
                      widget.onValider!();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 40),
                      elevation: 0,
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      "Laisser un avis",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "NeueRegrade",
                        color: AppColors.dark,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}