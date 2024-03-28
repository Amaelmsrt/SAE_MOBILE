import 'dart:ffi';
import 'dart:math';

import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/listing_categories.dart';
import 'package:allo/components/user_preview.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/widgets/page_aider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import your color file

class DetailAnnonce extends StatefulWidget {
  final String titre;
  final String imagePath;
  bool isSaved;
  final double prix;
  final bool estUrgente;

  DetailAnnonce(
      {required this.titre,
      required this.imagePath,
      required this.isSaved,
      required this.prix,
      required this.estUrgente});

  @override
  State<DetailAnnonce> createState() => _DetailAnnonceState();
}

class _DetailAnnonceState extends State<DetailAnnonce> {
  late ScrollController _scrollController;
  bool _showTopBar = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > 100 && !_showTopBar) {
          setState(() {
            _showTopBar = true;
          });
        } else if (_scrollController.offset <= 100 && _showTopBar) {
          setState(() {
            _showTopBar = false;
          });
        }
      });
  }

  //annoncesimiliares
  // final List<Annonce> lesAnnonces = [
  //   Annonce(
  //     titre: 'Annonce 1',
  //     imageLink: 'assets/perceuse.jpeg',
  //     isSaved: false,
  //     prix: 100,
  //     niveauUrgence: 1,
  //   ),
  //   Annonce(
  //     titre: 'Annonce 2',
  //     imageLink: 'assets/perceuse.jpeg',
  //     isSaved: true,
  //     prix: 200,
  //     niveauUrgence: 2,
  //   ),
  //   Annonce(
  //     titre: 'Annonce 3',
  //     imageLink: 'assets/perceuse.jpeg',
  //     isSaved: false,
  //     prix: 300,
  //     niveauUrgence: 3,
  //   ),
  //   Annonce(
  //     titre: 'Annonce 4',
  //     imageLink: 'assets/perceuse.jpeg',
  //     isSaved: true,
  //     prix: 400,
  //     niveauUrgence: 4,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0, top: 0),
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
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
                            widget.imagePath,
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Titre: ${widget.titre}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NeueRegrade",
                              ),
                            ),
                            Row(
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
                                Text('${widget.prix} €',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: AppColors.accent,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "NeueRegrade",
                                    )),
                              ],
                            ),
                            SizedBox(height: 24),
                            UserPreview(
                                nbAvis: 158,
                                nbEtoiles: 2,
                                pseudo: "Julien Arsouze"),
                            SizedBox(height: 24),
                            Text("Description",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "NeueRegrade",
                                )),
                            SizedBox(height: 16),
                            Text(
                                "Bonjour à tous, Je me lance dans une série de projets de bricolage et j’ai rapidement réalisé que je suis en manque d’un outil essentiel - une perceuse robuste et efficace. Je cherche donc une perceuse qui peut me soutenir dans divers travaux, que ce soit pour assembler des meubles, fixer des étagères ou même entreprendre des petites rénovations.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "NeueRegrade",
                                )),
                            SizedBox(height: 24),
                            ListingCategories(lesCategories: [
                              "Outils",
                              "Perceuse",
                              "Bricolage",
                              "Perceur",
                              "Saucisson"
                            ]),
                            SizedBox(height: 24),
                            //ListeAnnonce(
                            //    titre: "Annonces similaires",
                            //    annonces: lesAnnonces),
                            SizedBox(height: 132),
                          ],
                        )),
                  ],
                ),
              )),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: AnimatedOpacity(
              opacity: _showTopBar ? 1.0 : 0.0,
              duration: Duration(
                  milliseconds: 300), // Changez ceci à la durée que vous voulez
              child: Container(
                height: 110,
                width: MediaQuery.of(context).size.width,
                color: AppColors.light,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 100,
            child: AnimatedOpacity(
              opacity: _showTopBar ? 1.0 : 0.0,
              duration: Duration(
                  milliseconds: 300), // Changez ceci à la durée que vous voulez
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: Text(widget.titre,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "NeueRegrade",
                    )),
              ),
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                color: AppColors.light,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double buttonWidth = constraints.maxWidth /
                          2.2; // 1.1 (pour le bouton de gauche) + 1.1 * 1.2 (pour le bouton de droite) = 2.2

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: buttonWidth,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.isSaved = !widget.isSaved;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: widget.isSaved
                                      ? AppColors.yellow
                                      : AppColors.lightSecondary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        "assets/icons/bookmark.svg",
                                        color: AppColors.dark,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        widget.isSaved
                                            ? 'Enregistré'
                                            : 'Enregistrer',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "NeueRegrade",
                                          color: AppColors.dark,
                                        ),
                                      ),
                                    ])),
                          ),
                          Container(
                            width: 1.1 * buttonWidth,
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return PageAider();
                                  },
                                  isScrollControlled: true,
                                  useRootNavigator: true, // Ajoutez cette ligne
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.symmetric(vertical: 15),
                                elevation: 0,
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Text(
                                'Aider',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "NeueRegrade",
                                  color: AppColors.dark,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )),
          )
        ],
      ),

      // un bouton enregistrer et un bouton aider
    );
  }
}
