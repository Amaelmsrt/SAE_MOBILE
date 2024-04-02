import 'dart:typed_data';

import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/objet.dart';
import 'package:allo/widgets/ajouter_avis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VueGestionObjetAnnonce extends StatefulWidget {
  final Annonce? annonce;
  final Objet? objet;

  bool get isAnnonce => annonce != null;

  VueGestionObjetAnnonce.forAnnonce({
    required Annonce annonce,
  })  : annonce = annonce,
        objet = null;

  // Constructeur pour Objet
  VueGestionObjetAnnonce.forObjet({
    required Objet objet,
  })  : objet = objet,
        annonce = null;

  @override
  _VueGestionObjetAnnonceState createState() => _VueGestionObjetAnnonceState();
}

class _VueGestionObjetAnnonceState extends State<VueGestionObjetAnnonce> {
  String secondButtonText() {
    if (widget.isAnnonce) {
      switch (widget.annonce!.etatAnnonce) {
        case Annonce.EN_COURS:
          return "Modifier l'annonce";
        case Annonce.AIDE_PLANIFIEE:
          return "Voir les modalités";
        case Annonce.ANNULEE:
          return "Voir les modalités";
        case Annonce.CLOTUREES:
          return "Laisser un avis";
        default:
          return "Modifier l'annonce";
      }
    } else {
      switch (widget.objet!.statutObjet) {
        case Objet.DISPONIBLE:
          return "Aider quelqu'un";
        case Objet.RESERVE:
          return "Voir les modalités";
        case Objet.INDISPONIBLE:
          return "Voir les modalités";
        default:
          return "Aider quelqu'un";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.lightSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // affiche l'image de l'objet avec des bords arrondis
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.memory(
                  widget.isAnnonce
                      ? widget.annonce!.images[0]
                      : widget.objet!.photoObjet!,
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isAnnonce
                          ? widget.annonce!.titreAnnonce
                          : widget.objet!.nomObjet,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: "NeueRegrade",
                        color: AppColors.dark,
                      ),
                    ),
                    Text(
                      "17 annonces correspondent a votre objet mec ça va ou quoiiiihihihihihihi",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: "NeueRegrade",
                        color: AppColors.dark,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (widget.isAnnonce) {
                    switch (widget.annonce!.etatAnnonce) {
                      case Annonce.EN_COURS:
                        break;
                      case Annonce.AIDE_PLANIFIEE:
                        break;
                      case Annonce.ANNULEE:
                        break;
                      case Annonce.CLOTUREES:
                        // on va sur la page d'avis
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return AjouterAvis(annonce:widget.annonce!, descriptionResume: "vous a aide le 17/07/204",);
                          },
                          isScrollControlled: true,
                          useRootNavigator: true, // Ajoutez cette ligne
                        );
                        break;
                    }
                  } else {
                    switch (widget.objet!.statutObjet) {
                      case Objet.DISPONIBLE:
                        break;
                      case Objet.RESERVE:
                        break;
                      case Objet.INDISPONIBLE:
                        break;
                    }
                  }
                },
                child: AnimatedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  duration: Duration(milliseconds: 300), // Durée de l'animation
                  curve: Curves.easeInOut, // Type d'animation
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      secondButtonText(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: "NeueRegrade",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: () {},
                child: AnimatedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  duration: Duration(milliseconds: 300), // Durée de l'animation
                  curve: Curves.easeInOut, // Type d'animation
                  decoration: BoxDecoration(
                    color: widget.isAnnonce
                        ? widget.annonce!.getEtatColor()
                        : widget.objet!.getStatusColor(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      widget.isAnnonce
                          ? widget.annonce!.getEtatStr()
                          : widget.objet!.getStatusStr(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: "NeueRegrade",
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
