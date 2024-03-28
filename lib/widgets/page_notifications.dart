import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/models/annonce.dart';
import 'package:flutter/material.dart';
import '../models/DB/annonce_db.dart';

class PageNotifications extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PageNotifications> {
  List<Annonce> lesAnnonces = [];

  @override
  void initState() {
    super.initState();
    fetchAnnonces();
  }

  Future<void> fetchAnnonces() async {
    final annonces = await AnnonceDB.fetchAllAnnonces();
    setState(() {
      lesAnnonces = annonces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (ListView(
        children: <Widget>[
          Padding(
              padding: new EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: CustomTextField(
                  hint: "Rechercher une annonce...",
                  iconPath: "assets/icons/loupe.svg")),
          ListeAnnonce(titre: "Vous pouvez les aider !", annonces: lesAnnonces),
          ListeAnnonce(titre: "Annonces urgentes", annonces: lesAnnonces),
          ListeAnnonce(titre: "Annonces récentes", annonces: lesAnnonces),
        ],
      )
    );
  }
}