import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/models/annonce.dart';
import 'package:flutter/material.dart';

class PageProfil extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PageProfil> {

  // fais un exemple de liste avec quelques annonces
  final List<Annonce> lesAnnonces = [
    Annonce(
      titre: 'Annonce 1',
      imageLink: 'assets/perceuse.jpeg',
      isSaved: false,
      prix: 100,
      niveauUrgence: 1,
    ),
    Annonce(
      titre: 'Annonce 2',
      imageLink: 'assets/perceuse.jpeg',
      isSaved: true,
      prix: 200,
      niveauUrgence: 2,
    ),
    Annonce(
      titre: 'Annonce 3',
      imageLink: 'assets/perceuse.jpeg',
      isSaved: false,
      prix: 300,
      niveauUrgence: 3,
    ),
    Annonce(
      titre: 'Annonce 4',
      imageLink: 'assets/perceuse.jpeg',
      isSaved: true,
      prix: 400,
      niveauUrgence: 4,
    ),
  ];

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
