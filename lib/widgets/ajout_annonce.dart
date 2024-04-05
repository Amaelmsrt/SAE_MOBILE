import 'dart:ffi';

import 'package:allo/components/add_images.dart';
import 'package:allo/components/custom_check_box.dart';
import 'package:allo/components/custom_date_picker.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/listing_categories.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/annonce_db.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/image_converter.dart';
import 'package:allo/utils/bottom_round_clipper.dart';
import 'package:allo/widgets/home.dart';
import 'package:allo/widgets/register_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AjoutAnnonce extends StatefulWidget {
  Annonce? annonce;

  AjoutAnnonce({this.annonce});

  @override
  State<AjoutAnnonce> createState() => _AjoutAnnonceState();
}

class _AjoutAnnonceState extends State<AjoutAnnonce>
    with AutomaticKeepAliveClientMixin {
  ValueNotifier<List<XFile>> images = ValueNotifier<List<XFile>>([]);

  TextEditingController _texteAnnonceController = TextEditingController();

  TextEditingController descriptionAnnonce = TextEditingController();

  ValueNotifier<DateTime> dateAideAnnonce =
      ValueNotifier<DateTime>(DateTime.now());

  ValueNotifier<List<String>> categorieNonSelectionnesAnnonce =
      ValueNotifier<List<String>>([]);

  ValueNotifier<List<String>> categorieAnnonce =
      ValueNotifier<List<String>>([]);

  ValueNotifier<bool> estUrgente = ValueNotifier<bool>(false);

  TextEditingController remunerationAnnonce = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAnnonceDetails();
  }

  Future<void> loadAnnonceDetails() async {
    if (widget.annonce != null) {
      _texteAnnonceController.text = widget.annonce!.titreAnnonce;
      descriptionAnnonce.text = widget.annonce!.descriptionAnnonce!;
      dateAideAnnonce.value = widget.annonce!.dateAideAnnonce!;
      categorieAnnonce.value = widget.annonce!.categories;
      categorieNonSelectionnesAnnonce.value = widget.annonce!.categories;
      estUrgente.value = widget.annonce!.estUrgente;
      print("Remuneration: ${widget.annonce!.prixAnnonce.toString()}");
      remunerationAnnonce.text = widget.annonce!.prixAnnonce.toString();

      for (var image in widget.annonce!.images) {
        XFile xFile = await ImageConverter.Uint8ListToXFile(image);
        images.value.add(xFile);
      }
      setState(() {});
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: AppColors.light,
        body: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 110.0),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        AddImages(valueNotifier: images),
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return CustomTextField(
                              hint: "Recherche une perceuse...",
                              label: "Titre de l'annonce",
                              controller: _texteAnnonceController,
                            );
                          },
                        ),
                        CustomTextField(
                            hint: "Description de l'annonce",
                            label: "Description",
                            isArea: true,
                            controller: descriptionAnnonce),
                        ListingCategories(
                          listeningToStrings: [
                            _texteAnnonceController,
                            descriptionAnnonce
                          ],
                          isSelectable: true,
                          isExpandable: true,
                          selectedCategoriesNotifier: categorieAnnonce,
                          categoriesNotifier: categorieNonSelectionnesAnnonce,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        CustomDatePicker(
                          hint: "Selectionner une date",
                          label: "Date de fin de l'annonce",
                          dateNotifier: dateAideAnnonce,
                        ),
                        CustomCheckBox(
                          label: "Niveau d'urgence",
                          hint: "Annonce urgente",
                          isCheckedNotifier: estUrgente,
                        ),
                        CustomTextField(
                          hint: "0.0",
                          label: "Rémunération de l'aide",
                          isPrice: true,
                          controller: remunerationAnnonce,
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                child: Text(
                    widget.annonce != null
                        ? "Modifier l'annonce"
                        : "Nouvelle annonce",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: "NeueRegrade",
                    )),
              ),
            ),
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
                    onPressed: () async {
                      print("Ajout/modif de l'annonce");
                      print("nb images: ${images.value.length}");
                      print("Titre: ${_texteAnnonceController.text}");
                      print("Description: ${descriptionAnnonce.text}");
                      print("Date: ${dateAideAnnonce.value}");
                      print("Categorie: ${categorieAnnonce.value}");
                      print("Urgence: ${estUrgente.value}");
                      print("Remuneration: ${remunerationAnnonce.text}");
                      if (widget.annonce == null){
                        AnnonceDB.ajouterAnnonce(
                            images.value,
                            _texteAnnonceController.text,
                            descriptionAnnonce.text,
                            dateAideAnnonce.value,
                            categorieAnnonce.value,
                            estUrgente.value,
                            remunerationAnnonce.text.isEmpty
                                ? 0
                                : double.parse(remunerationAnnonce.text));
                      }
                      else{
                        print("Annonce ID: ${widget.annonce!.idAnnonce}");
                        AnnonceDB.modifierAnnonce(
                            images.value,
                            _texteAnnonceController.text,
                            descriptionAnnonce.text,
                            dateAideAnnonce.value,
                            categorieAnnonce.value,
                            estUrgente.value,
                            remunerationAnnonce.text.isEmpty
                                ? 0
                                : double.parse(remunerationAnnonce.text),
                            widget.annonce!.idAnnonce);
                      }
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
                      widget.annonce == null
                          ? "Ajouter l'annonce"
                          : "Modifier l'annonce",
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
