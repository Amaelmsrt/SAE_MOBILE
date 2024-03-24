import 'dart:ffi';

import 'package:allo/components/card_annonce.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import your color file

class ListeAnnonce extends StatelessWidget {
  final String? titre;
  final List<Annonce> annonces;
  final bool isVertical;

  ListeAnnonce({this.titre, required this.annonces, this.isVertical = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (titre != null)
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                titre!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: "NeueRegrade",
                ),
              ),
            ),
          if (!isVertical)
            Container(
              height: 215,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: annonces.length,
                itemBuilder: (context, index) {
                  Annonce annonce = annonces[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: CardAnnonce(
                      titre: annonce.titreAnnonce,
                      imagePath: "", // A remplacer par le lien de l'image de l'annonce
                      isSaved: false, // A remplacer par l'état de sauvegarde de l'annonce
                      prix: 0, // A remplacer par le prix de l'annonce
                      niveauUrgence: annonce.estUrgente ? 1 : 0, // A remplacer par le niveau d'urgence de l'annonce
                    ),
                  );
                },
              ),
            ),
          if (isVertical)
            Container(
              height: 490,
              decoration: BoxDecoration(),
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.82,
                  mainAxisSpacing: 10,
                ),
                itemCount: annonces.length,
                itemBuilder: (context, index) {
                  Annonce annonce = annonces[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 12, left: 12),
                    child: CardAnnonce(
                      titre: annonce.titreAnnonce,
                      imagePath: "", // A remplacer par le lien de l'image de l'annonce
                      isSaved: false, // A remplacer par l'état de sauvegarde de l'annonce
                      prix: 0, // A remplacer par le prix de l'annonce
                      niveauUrgence: annonce.estUrgente ? 1 : 0, // A remplacer par le niveau d'urgence de l'annonce
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}