import 'dart:ffi';

import 'package:allo/constants/app_colors.dart';
import 'package:allo/widgets/detail_annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import your color file

class CardAnnonce extends StatelessWidget {
  final String titre;
  final String imagePath;
  final bool isSaved;
  final double prix;
  final int niveauUrgence;

  CardAnnonce(
      {required this.titre,
      required this.imagePath,
      required this.isSaved,
      required this.prix,
      required this.niveauUrgence});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailAnnonce(
                  titre: titre,
                  imagePath: imagePath,
                  isSaved: isSaved,
                  prix: prix,
                  niveauUrgence: niveauUrgence,
                )),
          )
        },
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: 150, // définir la largeur
                      height: 150, // définir la hauteur
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(15), // arrondir les bords
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit
                              .cover, // pour s'assurer que l'image couvre tout le rectangle
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                        decoration: BoxDecoration(
                          color: AppColors.danger,
                          borderRadius: BorderRadius.circular(500000),
                        ),
                        child: Text(
                          'Urgence: $niveauUrgence',
                          style: TextStyle(
                              color: AppColors.dark,
                              fontFamily: "NeueRegrade",
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                  child: Text(titre,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "NeueRegrade",
                          fontWeight: FontWeight.w600)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/icons/bookmark.svg',
                        width: 18,
                        height: 18,
                      ),
                      Text('$prix \€',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "NeueRegrade",
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
