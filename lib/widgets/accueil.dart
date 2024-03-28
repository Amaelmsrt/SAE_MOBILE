import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/DB/annonce_db.dart';

class Accueil extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Accueil> {
  List<Annonce> toutesLesAnnonces = [];
  List<Annonce> dernieresAnnonces = [];
  List<Annonce> annoncesUrgentes = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppBarTitle>(context, listen: false).setTitle('Accueil');
    });
    fetchAnnonces();
  }

  Future<void> fetchAnnonces() async {
    final allAnnonces = await AnnonceDB.fetchAllAnnonces();
    final lastAnnonces = await AnnonceDB.fetchLastAnnonces();
    final urgentAnnonces = await AnnonceDB.fetchUrgentAnnonces();

    setState(() {
      toutesLesAnnonces = allAnnonces;
      dernieresAnnonces = lastAnnonces;
      annoncesUrgentes = urgentAnnonces;
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
          ListeAnnonce(titre: "Vous pouvez les aider !", annonces: toutesLesAnnonces),
          ListeAnnonce(titre: "Annonces urgentes", annonces: annoncesUrgentes),
          ListeAnnonce(titre: "Annonces récentes", annonces: dernieresAnnonces),
        ],
      )
    );
  }
}