import 'package:allo/components/top_selection_menu.dart';
import 'package:allo/components/vue_gestion_objet_annonce.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/annonce_db.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/index_page_notifications.dart';
import 'package:allo/widgets/ajout_annonce.dart';
import 'package:allo/widgets/ajouter_avis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MesAnnonces extends StatefulWidget {
  @override
  _MesAnnoncesState createState() => _MesAnnoncesState();
}

class _MesAnnoncesState extends State<MesAnnonces> {
  PageController _pageController = PageController();
  late Future<List<Annonce>> mesAnnonces = AnnonceDB.getMesAnnonces();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppBarTitle>(context, listen: false).setTitle('Mes annonces');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          children: <Widget>[
            Center(
                child: TopSelectionMenu(
              items: ["Toutes", "En cours", "Cloturées"],
              onItemSelected: (int index) {
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            )),
            SizedBox(
              height: 24,
            ),
            Expanded(
              // Ajoutez ce widget
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  Provider.of<IndexPageNotifications>(context, listen: false)
                      .setIndex(index);
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: FutureBuilder<List<Annonce>>(
                      future: mesAnnonces,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Erreur: ${snapshot.error}');
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var annonce = snapshot.data![index];
                              return VueGestionObjetAnnonce.forAnnonce(
                                annonce: annonce,
                            
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: FutureBuilder<List<Annonce>>(
                      future: mesAnnonces,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Erreur: ${snapshot.error}');
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var annonce = snapshot.data![index];
                              if (annonce.etatAnnonce == Annonce.EN_COURS) {
                                return VueGestionObjetAnnonce.forAnnonce(
                                  annonce: annonce,
                                 
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                 Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: FutureBuilder<List<Annonce>>(
                      future: mesAnnonces,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Erreur: ${snapshot.error}');
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var annonce = snapshot.data![index];
                              if (annonce.etatAnnonce == Annonce.CLOTUREES) {
                                return VueGestionObjetAnnonce.forAnnonce(
                                  annonce: annonce,
                                 
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
