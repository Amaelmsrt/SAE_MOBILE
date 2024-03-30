import 'dart:math';

import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/listing_categories.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/categorie_db.dart';
import 'package:allo/utils/bottom_round_clipper.dart';
import 'package:allo/widgets/home.dart';
import 'package:allo/widgets/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpandedCategories extends StatefulWidget {
  List<String> lesCategories = [];
  List<String> selectedCategories = [];

  final ValueNotifier<List<String>>? selectedCategoriesNotifier;
  TextEditingController searchBarTextController = TextEditingController();

  ExpandedCategories({required this.selectedCategoriesNotifier});

  @override
  State<ExpandedCategories> createState() => _ExpandedCategoriesState();
}

class _ExpandedCategoriesState extends State<ExpandedCategories>
    with TickerProviderStateMixin {
  Map<String, AnimationController> _controllers = {};

  String categoryBeingAnimated = "";

  void searchBarListener() {
    print("nouveau texte: " + widget.searchBarTextController.text);
    {
      CategorieDB.findMatchingCategories(
              text: widget.searchBarTextController.text)
          .then((List<String> value) {
        if (!mounted) {
          print("was not mounted");
          return;
        }
        setState(() {
          // on va supprimer les controleurs qui ne seront plus utilisés

          var keys = List<String>.from(_controllers.keys);

          for (var controller in keys) {
            if (!value.contains(controller) && !widget.selectedCategories.contains(controller)) {
              _controllers[controller]!.dispose();
              _controllers.remove(controller);
            }
          }

          // on enlève toutes les catégories dans lesCategories sauf celles qui sont déjà selectionnées

          widget.lesCategories.removeWhere(
              (element) => !widget.selectedCategories.contains(element));

          for (var categ in value) {
            if (!widget.lesCategories.contains(categ)) {
              widget.lesCategories.add(categ);
              _controllers[categ] = AnimationController(
                duration: const Duration(milliseconds: 250),
                vsync: this,
              );
            }
          }
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // on ajoute toutes les catégories selectionnées (dans le notifier) dans les catégories selectionnées et les catégories

    for (var category in widget.selectedCategoriesNotifier!.value) {
      if (!widget.selectedCategories.contains(category)) {
        widget.selectedCategories.add(category);
      }
      if (!widget.lesCategories.contains(category)) {
        widget.lesCategories.add(category);
        _controllers[category] = AnimationController(
          duration: const Duration(milliseconds: 250),
          vsync: this,
        );
      }
    }

    widget.searchBarTextController.addListener(searchBarListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();

    widget.searchBarTextController.removeListener(searchBarListener);
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
                        noSpacing: true,
                        controller: widget.searchBarTextController),
                    Expanded(
                      child: ListView(
                        children:
                            this.widget.lesCategories.map<Widget>((category) {
                          bool isSelected =
                              widget.selectedCategories.contains(category);
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Handle tap
                                setState(() {
                                  if (isSelected) {
                                    widget.selectedCategories.remove(category);
                                    _controllers[category]!.reverse();
                                  } else {
                                    widget.selectedCategories.add(category);
                                    _controllers[category]!.forward();
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                margin: EdgeInsets.only(bottom: 10.0),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      category,
                                      style: TextStyle(
                                        fontFamily: "NeueRegrade",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    RotationTransition(
                                      turns: Tween(begin: 0.0, end: 1 / 8)
                                          .animate(_controllers[category] ??
                                              AnimationController(vsync: this)),
                                      child: SvgPicture.asset(
                                        "assets/icons/plus.svg",
                                        color: AppColors.dark,
                                        width: 21,
                                        height: 21,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
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
                child: Text("Nouvelle annonce",
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
                      widget.selectedCategoriesNotifier!.value =
                          widget.selectedCategories;
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
