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
  late Future<List<Annonce>> lesAnnonces =
      AnnonceDB.fetchAnnoncesEnregistrees();
  final TextEditingController _searchController = TextEditingController();
  Future<List<Annonce>>? _searchResults;

  void searchListener() {
    print("nouveau texte: " + _searchController.text);
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResults = null;
      });
    } else {
      AnnonceDB.findAnnonces(_searchController.text).then((List<String> value) {
        if (!mounted) {
          print("was not mounted");
          return;
        }
        if (_searchController.text.isEmpty) {
          return;
        }
        setState(() {
          _searchResults = Future.wait(value.map((title) {
            return AnnonceDB.fetchAnnonceByTitle(title);
          }));
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppBarTitle>(context, listen: false).setTitle('Accueil');
    });

    _searchController.addListener(searchListener);
  }

  @override
  void dispose() {
    _searchController.removeListener(searchListener);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (ListView(
      children: <Widget>[
        Padding(
            padding: new EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: CustomTextField(
                controller: _searchController,
                hint: "Rechercher une annonce...",
                iconPath: "assets/icons/loupe.svg")),
        FutureBuilder(
            future: _searchResults ?? lesAnnonces,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Erreur: ${snapshot.error}');
              } else {
                return ListeAnnonce(isVertical: true, annonces: snapshot.data!, hasSidePadding: true,);
              }
            }),
      ],
    ));
  }
}
