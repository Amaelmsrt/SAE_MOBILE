import 'dart:math';

import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/listing_categories.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/utils/bottom_round_clipper.dart';
import 'package:allo/widgets/home.dart';
import 'package:allo/widgets/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpandedCategories extends StatefulWidget {
  List<String> lesCategories;
  List<String> preSelectedCategories = [];
  List<String> selectedCategories = [];

  ExpandedCategories(
      {required this.lesCategories, this.preSelectedCategories = const []});

  @override
  State<ExpandedCategories> createState() => _ExpandedCategoriesState();
}

class _ExpandedCategoriesState extends State<ExpandedCategories>
    with TickerProviderStateMixin {
  Map<String, AnimationController> _controllers = {};

  String categoryBeingAnimated = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var category in widget.lesCategories) {
      _controllers[category] = AnimationController(
        duration: const Duration(milliseconds: 250),
        vsync: this,
      );
    }

    // on ajoute toutes les preselected categories dans les selected categories

    this.widget.preSelectedCategories.forEach((element) {
      this.widget.selectedCategories.add(element);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    for (var controller in _controllers.values) {
      controller.dispose();
    }
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
                        noSpacing: true),
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
                                      turns: Tween(begin: 0.0, end: 1 / 8).animate(_controllers[category] ?? AnimationController(vsync: this)),
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
          ],
        ));
  }
}
