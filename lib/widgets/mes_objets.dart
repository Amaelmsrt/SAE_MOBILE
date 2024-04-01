import 'package:allo/components/top_selection_menu.dart';
import 'package:allo/components/vue_gestion_objet_annonce.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/objet_bd.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/index_page_notifications.dart';
import 'package:allo/models/objet.dart';
import 'package:allo/widgets/ajouter_objet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MesObjets extends StatefulWidget {
  @override
  _MesObjetsState createState() => _MesObjetsState();
}

class _MesObjetsState extends State<MesObjets> {
  PageController _pageController = PageController();
  late Future<List<Objet>> mesObjets = ObjetBd.getMesObjets();

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
              items: ["Tous", "Réservés", "Disponibles"],
              onItemSelected: (int index) {
                _pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            )),
            SizedBox(
              height: 8,
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
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: FutureBuilder<List<Objet>>(
                        future: mesObjets,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Erreur: ${snapshot.error}');
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Center(
                                      child: Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.65, // 70% de la largeur du parent
                                        child: ElevatedButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return AjouterObjet();
                                                },
                                                isScrollControlled: true,
                                                useRootNavigator:
                                                    true, // Ajoutez cette ligne
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shadowColor: Colors.transparent,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 30),
                                              elevation: 0,
                                              backgroundColor:
                                                  AppColors.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Ajouter un objet",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "NeueRegrade",
                                                    color: AppColors.dark,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                SvgPicture.asset(
                                                  "assets/icons/plus.svg",
                                                  color: AppColors.dark,
                                                  height: 16,
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  );
                                }
                                var objet = snapshot.data![index - 1];
                                return Column(
                                  children: <Widget>[
                                    VueGestionObjetAnnonce.forObjet(
                                      objet: objet,
                                    ),
                                    SizedBox(
                                        height: index == snapshot.data!.length
                                            ? 32
                                            : 16)
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: FutureBuilder<List<Objet>>(
                        future: mesObjets,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Erreur: ${snapshot.error}');
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Center(
                                      child: Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.65, // 70% de la largeur du parent
                                        child: ElevatedButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return AjouterObjet();
                                                },
                                                isScrollControlled: true,
                                                useRootNavigator:
                                                    true, // Ajoutez cette ligne
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shadowColor: Colors.transparent,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 30),
                                              elevation: 0,
                                              backgroundColor:
                                                  AppColors.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Ajouter un objet",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "NeueRegrade",
                                                    color: AppColors.dark,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                SvgPicture.asset(
                                                  "assets/icons/plus.svg",
                                                  color: AppColors.dark,
                                                  height: 16,
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  );
                                }
                                var objet = snapshot.data![index - 1];
                                if (objet.statutObjet == Objet.RESERVE) {
                                  return Column(
                                    children: <Widget>[
                                      VueGestionObjetAnnonce.forObjet(
                                        objet: objet,
                                      ),
                                      SizedBox(
                                          height: index == snapshot.data!.length
                                              ? 32
                                              : 16)
                                    ],
                                  );
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: FutureBuilder<List<Objet>>(
                        future: mesObjets,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Erreur: ${snapshot.error}');
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Center(
                                      child: Container(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.65, // 70% de la largeur du parent
                                        child: ElevatedButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return AjouterObjet();
                                                },
                                                isScrollControlled: true,
                                                useRootNavigator:
                                                    true, // Ajoutez cette ligne
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shadowColor: Colors.transparent,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 30),
                                              elevation: 0,
                                              backgroundColor:
                                                  AppColors.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Ajouter un objet",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "NeueRegrade",
                                                    color: AppColors.dark,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                SvgPicture.asset(
                                                  "assets/icons/plus.svg",
                                                  color: AppColors.dark,
                                                  height: 16,
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                  );
                                }
                                var objet = snapshot.data![index - 1];
                                if (objet.statutObjet == Objet.DISPONIBLE) {
                                  return Column(
                                    children: <Widget>[
                                      VueGestionObjetAnnonce.forObjet(
                                        objet: objet,
                                      ),
                                      SizedBox(
                                          height: index == snapshot.data!.length
                                              ? 32
                                              : 16)
                                    ],
                                  );
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
