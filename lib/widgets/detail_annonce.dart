import 'dart:ffi';
import 'dart:math';

import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import your color file

class DetailAnnonce extends StatelessWidget {
  final String titre;
  final String imagePath;
  final bool isSaved;
  final double prix;
  final int niveauUrgence;

  DetailAnnonce(
      {required this.titre,
      required this.imagePath,
      required this.isSaved,
      required this.prix,
      required this.niveauUrgence});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      15), // change this to your desired border radius
                  bottomRight: Radius.circular(
                      15), // change this to your desired border radius
                ),
                child: Image.asset(
                  imagePath,
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 45,
                left: 25,
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
                      child: SvgPicture.asset(
                          "assets/icons/arrow-back.svg"), // your icon
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.only(left: 0, right: 0, top: 0),
                  title: Text(
                    'Titre: $titre',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "NeueRegrade",
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Publié le 19/07/2024 à 16h07',
                        style: TextStyle(
                          fontFamily: "NeueRegrade",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text('$prix €',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w700,
                            fontFamily: "NeueRegrade",
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.lightSecondary,
                            borderRadius: BorderRadius.circular(10000),
                          ),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ClipOval(
                                        child: Container(
                                          alignment: Alignment.center,
                                          color: AppColors.lightBlue,
                                          width:
                                              55.0, // you can adjust width and height to your liking
                                          height:
                                              55.0, // you can adjust width and height to your liking
                                          child: Text(
                                            'J',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              fontFamily: "NeueRegrade",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              10), // you can adjust the spacing to your liking
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Julien Arsouze'),
                                          Row(children: <Widget>[
                                            SvgPicture.asset("assets/icons/star.svg"),
                                            SvgPicture.asset("assets/icons/star.svg"),
                                            SvgPicture.asset("assets/icons/star.svg"),
                                            SvgPicture.asset("assets/icons/star.svg"),
                                            SvgPicture.asset("assets/icons/star.svg"),
                                            SizedBox(width: 8),
                                            Text('158 avis')
                                          ])
                                        ],
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 50, // same height as a FAB
                                      width: 50, // same width as a FAB
                                      decoration: BoxDecoration(
                                        color: AppColors
                                            .primary, // same color as your FAB
                                        borderRadius: BorderRadius.circular(
                                            8000), // change this to your desired border radius
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                            "assets/icons/chat.svg"), // your icon
                                      ),
                                    ),
                                  ),
                                ],
                              ))),
                        )))
                // add more ListTiles for more information
              ],
            ),
          )),
        ],
      ),
    );
  }
}
