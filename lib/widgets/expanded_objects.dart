import 'package:allo/components/custom_text_field.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/objet_bd.dart';
import 'package:allo/models/objet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpandedObjects extends StatefulWidget {
  final ValueNotifier<Objet?> objetSelectionneNotifier;

  ExpandedObjects({required this.objetSelectionneNotifier});

  @override
  _ExpandedObjectsState createState() => _ExpandedObjectsState();
}

class _ExpandedObjectsState extends State<ExpandedObjects> {
  String objectBeingAnimated = "";
  TextEditingController searchController = TextEditingController();

  late Future<List<Objet>> lesObjets = ObjetBd.getMesObjets(onlyDisponibles: true);

  Objet? objetSelectionneLocal = null;

  void searchTextChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(searchTextChanged);
    objetSelectionneLocal = widget.objetSelectionneNotifier.value;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light,
        body: Stack(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 110.0),
                child: Column(
                  children: [
                    CustomTextField(
                        hint: "Votre recherche...",
                        iconPath: "assets/icons/loupe.svg",
                        controller: searchController,
                        noSpacing: true),
                    Expanded(
                      child: FutureBuilder(
                        future: lesObjets,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ListView(
  children: snapshot.data!.map<Widget>((obj) {
    bool isSelected =
        (objetSelectionneLocal != null) &&
            (obj.idObjet ==
                objetSelectionneLocal!.idObjet);
    if (searchController.text.isNotEmpty &&
        !obj.nomObjet.toLowerCase().contains(
            searchController.text.toLowerCase()))
      return Container();
    return GestureDetector(
      onTap: () {
        // Handle tap
        setState(() {
          if (objetSelectionneLocal != null && objetSelectionneLocal!.idObjet == obj.idObjet)
            objetSelectionneLocal = null;
          else
            objetSelectionneLocal = obj;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 10.0),
        child: Row(
          children: <Widget>[
            // affiche l'image de l'objet avec des bords arrondis
            ClipRRect(
              borderRadius: BorderRadius.all(
                  Radius.circular(10)),
              child: Image.memory(
                obj.photoObjet,
                width: 65,
                height: 65,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(obj.nomObjet,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      fontFamily: "NeueRegrade",
                      color: AppColors.dark,
                    )),
                Text(obj.descriptionObjet,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: "NeueRegrade",
                      color: AppColors.dark,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }).toList(),
);
                          }
                        },
                      ),
                    ),
                  ],
                )),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 110,
                width: MediaQuery.of(context).size.width,
                color: AppColors.light,
                alignment: Alignment.center,
              ),
            ),
            Positioned(
              top: 45,
              left: 100,
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                alignment: Alignment.centerLeft,
                child: Text("Mes objets",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "NeueRegrade",
                    )),
              ),
            ),
            Positioned(
              top: 45,
              left: 25,
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
                    child: SvgPicture.asset(
                        "assets/icons/arrow-back.svg"), // your icon
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                color: AppColors.light,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.objetSelectionneNotifier.value =
                          objetSelectionneLocal;
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: 17, horizontal: 40),
                      elevation: 0,
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      "Enregistrer",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "NeueRegrade",
                        color: AppColors.dark,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
