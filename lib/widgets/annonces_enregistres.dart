import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/DB/annonce_db.dart';

class AnnoncesEnregistrees extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AnnoncesEnregistrees> {
  List<Annonce> lesAnnonces = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppBarTitle>(context, listen: false).setTitle('Annonces enregistrées');
    });
    fetchAnnonces();
  }

  Future<void> fetchAnnonces() async {
    final annonces = await AnnonceDB.fetchFirstAnnonces();
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
          ListeAnnonce(annonces: lesAnnonces, isVertical: true,)
        ],
      )
    );
  }
}