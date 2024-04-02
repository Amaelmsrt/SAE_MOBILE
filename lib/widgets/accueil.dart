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
  final TextEditingController _searchController = TextEditingController();
  Future<List<Annonce>>? _searchResults;

  void searchListener() {
    print("nouveau texte: " + _searchController.text);
    if (_searchController.text.isEmpty) {
      setState(() {
        _searchResults = null;
      });
    } else {
      AnnonceDB.findAnnonces(_searchController.text)
          .then((List<String> value) {
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
    return Padding(
      padding: new EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: new EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: CustomTextField(
                controller: _searchController,
                hint: "Rechercher une annonce...",
                iconPath: "assets/icons/loupe.svg"),
          ),
          _searchResults != null
              ? FutureBuilder(
                  future: _searchResults,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Erreur: ${snapshot.error}');
                    } else {
                      return ListeAnnonce(
                          titre: _searchController.text.isEmpty
                              ? "Vous pouvez les aider !"
                              : "Résultats de la recherche",
                          annonces: snapshot.data!,
                          isVertical: true);
                    }
                  },
                )
              : Column(
                  children: <Widget>[
                    buildAnnonceList(
                        toutesLesAnnonces, "Vous pouvez les aider !"),
                    SizedBox(height: 24),
                    buildAnnonceList(
                        dernieresAnnonces, "Vous pouvez les aider !"),
                    SizedBox(height: 24),
                    buildAnnonceList(
                        annoncesUrgentes, "Vous pouvez les aider !"),
                    SizedBox(height: 24),
                  ],
                ),
        ],
      ),
    );
  }

  Widget buildAnnonceList(Future<List<Annonce>> annoncesFuture, String titre) {
    return FutureBuilder(
      future: annoncesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListeAnnonce(titre: titre, annonces: snapshot.data!);
        }
      },
    );
  }
}
