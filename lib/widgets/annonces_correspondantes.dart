import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/annonce_db.dart';
import 'package:allo/models/DB/objet_bd.dart';
import 'package:allo/models/annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnnoncesCorrespondantes extends StatefulWidget {
  String idObjet;

  AnnoncesCorrespondantes({required this.idObjet});

  @override
  State<AnnoncesCorrespondantes> createState() => _AnnoncesCorrespondantesState();
}

class _AnnoncesCorrespondantesState extends State<AnnoncesCorrespondantes> {
  TextEditingController _searchController = TextEditingController();
  late Future<List<Annonce>> lesAnnonces =
      ObjetBd.fetchAnnoncesCorrespondantes(widget.idObjet);

  Future<List<Annonce>>? _searchResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: <Widget>[
              Padding(
                  padding: new EdgeInsets.fromLTRB(15, 120, 15, 0),
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
                      return ListeAnnonce(
                          isVertical: true, annonces: snapshot.data!);
                    }
                  }),
            ],
          ),
          Positioned(
            top: 45,
            right: 10,
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Center(
                  child: Text("Aidez quelqu'un!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: "NeueRegrade",
                      ))),
            ),
          ),
          if (Navigator.canPop(context))
            Positioned(
              top: 45,
              right: 25,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 45, // same height as a FAB
                  width: 45, // same width as a FAB
                  decoration: BoxDecoration(
                    color: AppColors.primary, // same color as your FAB
                    borderRadius: BorderRadius.circular(
                        8000), // change this to your desired border radius
                  ),
                  child: Center(
                    child:
                        SvgPicture.asset("assets/icons/cross.svg"), // your icon
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
