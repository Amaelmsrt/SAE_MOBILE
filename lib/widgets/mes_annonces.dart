import 'package:allo/components/top_selection_menu.dart';
import 'package:allo/components/vue_gestion_objet_annonce.dart';
import 'package:allo/constants/app_colors.dart';
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
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Column(
                              children: [
                                VueGestionObjetAnnonce(
                                    imagePath: "assets/perceuse.jpeg",
                                    titre: "cherche perceuse",
                                    description: "l'annonce est en cours",
                                    couleurEtat: AppColors.yellow,
                                    etat: "en cours",
                                    action: "promouvoir",
                                    actionFunction: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return AjouterAvis();
                                        },
                                        isScrollControlled: true,
                                        useRootNavigator:
                                            true, // Ajoutez cette ligne
                                      );
                                    }),
                                SizedBox(height: 16),
                              ],
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
