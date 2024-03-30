import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/categorie_db.dart';
import 'package:allo/widgets/expanded_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListingCategories extends StatefulWidget {
  List<String>? lesCategories;
  bool isSelectable;
  bool isExpandable;
  final ValueNotifier<List<String>>? categoriesNotifier;
  final ValueNotifier<List<String>>? selectedCategoriesNotifier;
  TextEditingController? listeningToString;

  ListingCategories(
      {this.lesCategories,
      this.isSelectable = false,
      this.isExpandable = false,
      this.selectedCategoriesNotifier,
      this.categoriesNotifier,
      this.listeningToString});

  @override
  State<ListingCategories> createState() => _ListingCategoriesState();
}

class _ListingCategoriesState extends State<ListingCategories> {
  void ListenerFunction() {
    print("nouveau texte: " + widget.listeningToString!.text);
    try {
      if (widget.selectedCategoriesNotifier!.value.length <= 4) {
        CategorieDB.findMatchingCategories(
                text: widget.listeningToString!.text,
                nbToFind: 5 - widget.selectedCategoriesNotifier!.value.length)
            .then((List<String> value) {
          if (!mounted) {
            print("not mounted");
            return;
          }
          print("categories trouvées: " + value.toString());
          setState(() {
            // on enlève toutes les catégories dans lesCategories sauf celles qui sont déjà selectionnées
            widget.categoriesNotifier!.value.removeWhere(
                (element) => !widget.selectedCategoriesNotifier!.value.contains(element));

            for (var categ in value) {
              if (!widget.categoriesNotifier!.value.contains(categ)) {
                widget.categoriesNotifier!.value.add(categ);
              }
            }
          });
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void selectedValuesHaveChanged() {
    if (widget.selectedCategoriesNotifier != null) {
      print("selected values have changed");
      print(
          "new values: " + widget.selectedCategoriesNotifier!.value.toString());
      setState(() {
        
        // on supprime toutes les valeurs qui sont dans selectedCatogires mais pas dans selectedCategoriesNotifier

        widget.categoriesNotifier!.value.removeWhere(
            (element) => !widget.selectedCategoriesNotifier!.value.contains(element));

        for (var cat in widget.selectedCategoriesNotifier!.value) {
          if (!widget.categoriesNotifier!.value.contains(cat)) {
            widget.categoriesNotifier!.value.add(cat);
          }
        }
      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.listeningToString != null) {
      widget.listeningToString!.addListener(ListenerFunction);
    }

    if (widget.selectedCategoriesNotifier != null) {
      widget.selectedCategoriesNotifier!.addListener(selectedValuesHaveChanged);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (widget.listeningToString != null) {
      widget.listeningToString!.removeListener(ListenerFunction);
    }

    if (widget.selectedCategoriesNotifier != null) {
      widget.selectedCategoriesNotifier!
          .removeListener(selectedValuesHaveChanged);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Catégories",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: "NeueRegrade",
            )),
        SizedBox(height: 16),
        Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0, // gap between lines
          children: widget.lesCategories == null
              ? widget.categoriesNotifier!.value.map<Widget>((category) {
                  return GestureDetector(
                    onTap: widget.isSelectable
                        ? () {
                            setState(() {
                              if (widget.selectedCategoriesNotifier!.value
                                  .contains(category)) {
                                widget.selectedCategoriesNotifier!.value.remove(category);
                              } else {
                                widget.selectedCategoriesNotifier!.value.add(category);
                              }
                            });
                          }
                        : null,
                    child: Chip(
                      backgroundColor:
                          widget.selectedCategoriesNotifier!.value.contains(category)
                              ? AppColors.primary
                              : AppColors.lightSecondary,
                      label: Text(
                        category,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "NeueRegrade",
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // increase this for a more rounded border
                        side: BorderSide(
                            color: Colors
                                .transparent), // this makes the border transparent
                      ),
                    ),
                  );
                }).toList()
              : widget.lesCategories!.map<Widget>((category) {
                  return GestureDetector(
                    onTap: widget.isSelectable
                        ? () {
                            setState(() {
                              if (widget.categoriesNotifier!.value
                                  .contains(category)) {
                                widget.selectedCategoriesNotifier!.value.remove(category);
                              } else {
                               widget.selectedCategoriesNotifier!.value.add(category);
                              }
                            });
                          }
                        : null,
                    child: Chip(
                      backgroundColor:
                          AppColors.lightSecondary,
                      label: Text(
                        category,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "NeueRegrade",
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20), // increase this for a more rounded border
                        side: BorderSide(
                            color: Colors
                                .transparent), // this makes the border transparent
                      ),
                    ),
                  );
                }).toList(),
        ),
        if (widget.lesCategories != null && widget.lesCategories!.isEmpty)
          Text(
            "Pas de catégories",
          ),
        SizedBox(height: 10),
        if (widget.isExpandable)
          TextButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExpandedCategories(
                                selectedCategoriesNotifier:
                                    widget.selectedCategoriesNotifier!,
                              )),
                    )
                  },
              child: Row(
                children: [
                  Text(
                    "Autres catégories",
                    style: TextStyle(
                      fontFamily: "NeueRegrade",
                      color: AppColors.accent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SvgPicture.asset(
                    "assets/icons/plus.svg",
                    height: 15,
                  )
                ],
              ))
      ],
    );
  }
}
