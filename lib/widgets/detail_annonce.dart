import 'dart:ffi';
import 'dart:math';

import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/listing_categories.dart';
import 'package:allo/components/user_preview.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/annonce_db.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/widgets/page_aider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import your color file
import 'package:intl/intl.dart';

class DetailAnnonce extends StatefulWidget {
  Annonce annonce;

  DetailAnnonce({
    required this.annonce,
  });

  @override
  State<DetailAnnonce> createState() => _DetailAnnonceState();
}

class _DetailAnnonceState extends State<DetailAnnonce> {
  late ScrollController _scrollController;
  bool _showTopBar = false;

  late Future<Annonce> fetchDetails =
      AnnonceDB.fetchAnnonceDetails(widget.annonce.idAnnonce);

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
                          child: Image.memory(
                            widget.annonce.images[0],
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (widget.annonce.estUrgente)
                          Positioned(
                            right: 15,
                            bottom: 15,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
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
                                    fontSize: 18),
                              ),
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
                              widget.annonce.titreAnnonce,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NeueRegrade",
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FutureBuilder<Annonce>(
                                  future: fetchDetails,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      // Si les données sont en cours de chargement, vous pouvez retourner un indicateur de chargement
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      // Si une erreur s'est produite, vous pouvez retourner un widget d'erreur
                                      return Text('Une erreur s\'est produite');
                                    } else {
                                      // Si les données sont chargées, vous pouvez afficher la date de publication
                                      Annonce? annonce = snapshot.data;
                                      String formattedDate =
                                          DateFormat('dd/MM/yy à HH:mm').format(
                                              annonce?.datePubliAnnonce ??
                                                  DateTime.now());
                                      return Text(
                                        'Publié le $formattedDate',
                                        style: TextStyle(
                                          fontFamily: "NeueRegrade",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Text('${widget.annonce.prixAnnonce} €',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: AppColors.accent,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "NeueRegrade",
                                    )),
                              ],
                            ),
                            SizedBox(height: 24),
                            FutureBuilder(
                                future: fetchDetails,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Si les données sont en cours de chargement, vous pouvez retourner un indicateur de chargement
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // Si une erreur s'est produite, vous pouvez retourner un widget d'erreur
                                    return Text('Une erreur s\'est produite');
                                  } else {
                                    // Si les données sont chargées, vous pouvez afficher la description de l'annonce
                                    Annonce? annonce = snapshot.data;
                                    return UserPreview(
                                      utilisateur: annonce!.utilisateur!,
                                      annonce: widget.annonce,
                                    );
                                  }
                                }),
                            SizedBox(height: 24),
                            Text("Description",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "NeueRegrade",
                                )),
                            SizedBox(height: 16),
                            FutureBuilder<Annonce>(
                              future: fetchDetails,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Si les données sont en cours de chargement, vous pouvez retourner un indicateur de chargement
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  // Si une erreur s'est produite, vous pouvez retourner un widget d'erreur
                                  return Text('Une erreur s\'est produite');
                                } else {
                                  // Si les données sont chargées, vous pouvez afficher la description de l'annonce
                                  Annonce? annonce = snapshot.data;
                                  return Text(
                                    (annonce?.descriptionAnnonce?.isNotEmpty ??
                                            false)
                                        ? annonce!.descriptionAnnonce!
                                        : "Pas de description",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "NeueRegrade",
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 8),
                            FutureBuilder<Annonce>(
                              future: fetchDetails,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Si les données sont en cours de chargement, vous pouvez retourner un indicateur de chargement
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  // Si une erreur s'est produite, vous pouvez retourner un widget d'erreur
                                  return Text('Une erreur s\'est produite');
                                } else {
                                  // Si les données sont chargées, vous pouvez afficher la description de l'annonce
                                  Annonce? annonce = snapshot.data;
                                  String dateFormate = DateFormat('dd/MM/yyyy à HH:mm').format(annonce!.dateAideAnnonce!);
                                  return Text(
                                      "Pour le ${dateFormate}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.darkSecondary,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "NeueRegrade",
                                      ));
                                }
                              },
                            ),
                            SizedBox(height: 24),
                            FutureBuilder<Annonce>(
                              future: fetchDetails,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Si les données sont en cours de chargement, vous pouvez retourner un indicateur de chargement
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  // Si une erreur s'est produite, vous pouvez retourner un widget d'erreur
                                  return Text('Une erreur s\'est produite');
                                } else {
                                  // Si les données sont chargées, vous pouvez afficher la description de l'annonce
                                  Annonce? annonce = snapshot.data;
                                  return ListingCategories(
                                      lesCategories: annonce!.categories);
                                }
                              },
                            ),
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
              left: 90,
              child: Container(
                width: MediaQuery.of(context).size.width - 125,
                child: AnimatedOpacity(
                  opacity: _showTopBar ? 1.0 : 0.0,
                  duration: Duration(
                      milliseconds:
                          300), // Changez ceci à la durée que vous voulez
                  child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    alignment: Alignment.centerLeft,
                    child: Text(widget.annonce.titreAnnonce,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "NeueRegrade",
                        )),
                  ),
                ),
              )),
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
                                    widget.annonce.isSaved =
                                        !widget.annonce.isSaved;
                                    AnnonceDB.toggleSaveAnnonce(
                                        widget.annonce.idAnnonce);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: widget.annonce.isSaved
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
                                        widget.annonce.isSaved
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
                                    return PageAider(
                                      annonce: widget.annonce,
                                    );
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
