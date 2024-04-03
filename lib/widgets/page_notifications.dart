import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/top_selection_menu.dart';
import 'package:allo/components/vue_notification.dart';
import 'package:allo/components/vue_notification_message.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/message_bd.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/index_page_notifications.dart';
import 'package:allo/models/message.dart';
import 'package:allo/models/notification.dart';
import 'package:allo/models/notification_message.dart';
import 'package:flutter/material.dart';
import '../models/DB/annonce_db.dart';
import 'package:provider/provider.dart';

class PageNotifications extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PageNotifications> {

  // fais un exemple de liste avec quelques annonces
  PageController _pageController = PageController();

  late Future<List<Message>> conversations = MessageBD.getConversations();

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

  // les deux ont comme image assets/perceuse.jpeg
  // les deux ont comme titre d'annonce: Besoin d'une perceuse le 24/02/2024
  // les deux ont comme date: il y a 2 heures
  // un a comme intitulé: Vous avez reçu une demande de location
  // l'autre a comme intitulé: a enregistré votre annonce 
  List<NotificationAnnonce> notifsAnnonce = [
    NotificationAnnonce(
        imagePath: "assets/perceuse.jpeg",
        titreAnnonce: "Besoin d'une perceuse le 24/02/2024",
        date: "il y a 2 heures",
        intitule: "Vous avez reçu une demande de location"),
    NotificationAnnonce(
        imagePath: "assets/perceuse.jpeg",
        titreAnnonce: "Besoin d'une perceuse le 24/02/2024",
        date: "il y a 2 heures",
        intitule: "a enregistré votre annonce"),
     NotificationAnnonce(
        imagePath: "assets/perceuse.jpeg",
        titreAnnonce: "Besoin d'une perceuse le 24/02/2024",
        date: "il y a 2 heures",
        intitule: "Vous avez reçu une demande de location"),
    NotificationAnnonce(
        imagePath: "assets/perceuse.jpeg",
        titreAnnonce: "Besoin d'une perceuse le 24/02/2024",
        date: "il y a 2 heures",
        intitule: "a enregistré votre annonce"),
     NotificationAnnonce(
        imagePath: "assets/perceuse.jpeg",
        titreAnnonce: "Besoin d'une perceuse le 24/02/2024",
        date: "il y a 2 heures",
        intitule: "Vous avez reçu une demande de location"),
    NotificationAnnonce(
        imagePath: "assets/perceuse.jpeg",
        titreAnnonce: "Besoin d'une perceuse le 24/02/2024",
        date: "il y a 2 heures",
        intitule: "a enregistré votre annonce"),
  ];

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
        SizedBox(height: 24,),
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
                          return VueNotification(
                            imagePath: notifsAnnonce[index].imagePath,
                            titreAnnonce: notifsAnnonce[index].titreAnnonce,
                            date: notifsAnnonce[index].date,
                            intitule: notifsAnnonce[index].intitule,
                          );
                        },
                        childCount: notifsAnnonce.length,
                      ),
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FutureBuilder<List<Message>>(
                  future: conversations,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Erreur: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var message = snapshot.data![index];
                          return VueNotificationMessage(
                            message: message,
                            nbNotifs: 0,
                          );
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
    );
  }
}