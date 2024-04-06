import 'dart:typed_data';

import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/annonce_db.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/objet.dart';
import 'package:allo/widgets/ajout_annonce.dart';
import 'package:allo/widgets/ajouter_avis.dart';
import 'package:allo/widgets/annonces_correspondantes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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
          return widget.annonce!.avisLaisse
              ? "Voir mon avis"
              : "Laisser un avis";
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

  String getDescription() {
    if (widget.isAnnonce) {
      if (widget.annonce!.etatAnnonce == Annonce.EN_COURS) {
        return "En attente d'aide";
      } else if (widget.annonce!.etatAnnonce == Annonce.AIDE_PLANIFIEE) {
        String dateFormatee = DateFormat('dd/MM/yyyy à HH:mm')
            .format(widget.annonce!.dateAideAnnonce!);
        return "Aide planifiée le ${dateFormatee}";
      } else if (widget.annonce!.etatAnnonce == Annonce.ANNULEE) {
        return "Annonce annulée";
      } else if (widget.annonce!.etatAnnonce == Annonce.CLOTUREES) {
        String dateFormatee = DateFormat('dd/MM/yyyy à HH:mm')
            .format(widget.annonce!.dateAideAnnonce!);
        return "On vous a rendu service le ${dateFormatee}";
      }
    } else if (!widget.isAnnonce) {
      if (widget.objet!.statutObjet == Objet.DISPONIBLE) {
        int nbAnnonces = widget.objet!.nbAnnoncesCorrespondantes;
        return "${nbAnnonces == 0 ? "Aucune" : nbAnnonces} annonce${nbAnnonces > 1 ? "s" : ""} ${nbAnnonces > 1 ? "correspondent" : nbAnnonces == 1 ? "correspond" : "ne correspond"} à votre objet!";
      } else if (widget.objet!.statutObjet == Objet.RESERVE) {
        String dateFormatee = DateFormat('dd/MM/yyyy à HH:mm')
            .format(widget.objet!.dateReservation!);
        return "Réservée le ${dateFormatee}";
      }
    }
    return "desc à determiner";
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
                      getDescription(),
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
              if (!(widget.objet != null && widget.objet!.statutObjet == Objet.DISPONIBLE && widget.objet!.nbAnnoncesCorrespondantes == 0) && !(widget.annonce != null && widget.annonce!.etatAnnonce == Annonce.ANNULEE))
              GestureDetector(
                onTap: () {
                  if (widget.isAnnonce) {
                    switch (widget.annonce!.etatAnnonce) {
                      case Annonce.EN_COURS:
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return FutureBuilder(
                                future: AnnonceDB.getAnnonceWithDetails(
                                    widget.annonce!.idAnnonce),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return AjoutAnnonce(annonce: snapshot.data);
                                  } else {
                                    // un spinner au centre de l'écran
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                });
                          },
                          isScrollControlled: true,
                          useRootNavigator: true, // Ajoutez cette ligne
                        );
                        break;
                      case Annonce.AIDE_PLANIFIEE:
                        break;
                      case Annonce.ANNULEE:
                        break;
                      case Annonce.CLOTUREES:
                        // on va sur la page d'avis
                        if (widget.annonce!.avisLaisse) {
                          return;
                        }
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return AjouterAvis(
                              annonce: widget.annonce!,
                              descriptionResume: "vous a aidé le ${DateFormat('dd/MM/yyyy').format(widget.annonce!.dateAideAnnonce!)}",
                            );
                          },
                          isScrollControlled: true,
                          useRootNavigator: true, // Ajoutez cette ligne
                        );
                        break;
                    }
                  } else {
                    switch (widget.objet!.statutObjet) {
                      case Objet.DISPONIBLE:
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return AnnoncesCorrespondantes(idObjet: widget.objet!.idObjet);
                          },
                          isScrollControlled: true,
                          useRootNavigator: true, // Ajoutez cette ligne
                        );
                        break;
                      case Objet.RESERVE:
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
