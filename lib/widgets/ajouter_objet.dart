import 'package:allo/components/add_images.dart';
import 'package:allo/components/custom_check_box.dart';
import 'package:allo/components/custom_date_picker.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/listing_categories.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/utils/bottom_round_clipper.dart';
import 'package:allo/widgets/home.dart';
import 'package:allo/widgets/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AjouterObjet extends StatelessWidget {
  
  ValueNotifier<List<XFile>> images = ValueNotifier<List<XFile>>([]);

  @override
  Widget build(BuildContext context) {
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
                        AddImages(valueNotifier: images,),
                        CustomTextField(
                            hint: "Nom de l'objet...",
                            label: "Nom de l'objet"),
                        CustomTextField(
                            hint: "Description de l'objet...",
                            label: "Description de l'objet",
                            isArea: true),
                        ListingCategories(lesCategories: [
                          "Perceuse",
                          "Outils",
                          "Visseuse",
                          "Poulet",
                          "Gode ceinture"
                        ], isSelectable: true, isExpandable: true),
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
                child: Text("Nouvel objet",
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 17, horizontal: 40),
                      elevation: 0,
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      "Ajouter l'objet",
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
