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
  late Future<List<Annonce>> toutesLesAnnonces = AnnonceDB.fetchAllAnnonces();
  late Future<List<Annonce>> dernieresAnnonces = AnnonceDB.fetchLastAnnonces();
  late Future<List<Annonce>> annoncesUrgentes = AnnonceDB.fetchUrgentAnnonces();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppBarTitle>(context, listen: false).setTitle('Accueil');
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Padding(
        padding: new EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: CustomTextField(
                    hint: "Rechercher une annonce...",
                    iconPath: "assets/icons/loupe.svg")),

            FutureBuilder(future: toutesLesAnnonces, builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListeAnnonce(
                    titre: "Vous pouvez les aider !", annonces: snapshot.data!);
              }
            }),
            SizedBox(
              height: 24,
            ),
            FutureBuilder(future: dernieresAnnonces, builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListeAnnonce(
                    titre: "Vous pouvez les aider !", annonces: snapshot.data!);
              }
            }),
            SizedBox(
              height: 24,
            ),
            FutureBuilder(future: annoncesUrgentes, builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListeAnnonce(
                    titre: "Vous pouvez les aider !", annonces: snapshot.data!);
              }
            }),
            SizedBox(
              height: 24,
            ),
          ],
        )));
  }
}