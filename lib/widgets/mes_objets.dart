import 'package:allo/components/top_selection_menu.dart';
import 'package:allo/components/vue_gestion_objet_annonce.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/index_page_notifications.dart';
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
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
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
                                        backgroundColor: AppColors.primary,
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
                          } else {
                            return Column(
                              children: [
                                VueGestionObjetAnnonce(
                                  imagePath: "assets/perceuse.jpeg",
                                  titre: "cherche perceuse",
                                  description: "l'annonce est en cours",
                                  couleurEtat: AppColors.yellow,
                                  etat: "en cours",
                                  action: "promouvoir",
                                  actionFunction: () {},
                                ),
                                SizedBox(height: index == 5 ? 32 : 16),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Container(
                              color: Colors.blue,
                              height: 100,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Container(
                                  color: Colors.red,
                                  height: 100,
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
