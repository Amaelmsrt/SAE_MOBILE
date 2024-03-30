import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/widgets/detail_annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart'; // Import your color file

class CardAnnonce extends StatelessWidget {
  final Annonce annonce;

  CardAnnonce({required this.annonce});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailAnnonce(
                    annonce: annonce,
                  )),
        )
      },
      child: Container(
          width: 150,
          color: Colors.transparent,
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
                          color: Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(15), // arrondir les bords
                          image: DecorationImage(
                            image: MemoryImage(annonce.images[
                                0]), // Utiliser MemoryImage pour un Uint8List
                            fit: BoxFit
                                .cover, // pour s'assurer que l'image couvre tout le rectangle
                          ),
                        ),
                      ),
                      if (annonce.estUrgente)
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            decoration: BoxDecoration(
                              color: AppColors.danger,
                              borderRadius: BorderRadius.circular(500000),
                            ),
                            child: Text(
                              'Urgente',
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
                    child: Text(annonce.titreAnnonce,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
                          annonce.isSaved ? 'assets/icons/bookmark-filled.svg' : 'assets/icons/bookmark.svg',
                          width: 18,
                          height: 18, 
                          color: annonce.isSaved ? AppColors.yellow : AppColors.dark,
                        ),
                        Text('${annonce.prixAnnonce} \€',
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
          )),
    );
  }
}
