import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/top_selection_menu.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/index_page_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageNotifications extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PageNotifications> {
  // fais un exemple de liste avec quelques annonces
  PageController _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppBarTitle>(context, listen: false)
          .setTitle('Notifications');
      _pageController.jumpToPage(
          Provider.of<IndexPageNotifications>(context, listen: false).index);
    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
            child: TopSelectionMenu(
          items: ["Général", "Messages"],
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 500,
                  color: AppColors.lightBlue,
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 500,
                  color: AppColors.danger,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
