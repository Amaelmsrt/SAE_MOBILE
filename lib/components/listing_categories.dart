import 'package:allo/constants/app_colors.dart';
import 'package:allo/widgets/expanded_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListingCategories extends StatefulWidget {
  List<String> lesCategories;
  bool isSelectable;
  List<String> selectedCategories = [];
  bool isExpandable;

  ListingCategories(
      {required this.lesCategories,
      this.isSelectable = false,
      this.isExpandable = false});

  @override
  State<ListingCategories> createState() => _ListingCategoriesState();
}

class _ListingCategoriesState extends State<ListingCategories> {
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
          children: this.widget.lesCategories.map<Widget>((category) {
            return GestureDetector(
              onTap: widget.isSelectable
                  ? () {
                      setState(() {
                        if (widget.selectedCategories.contains(category))
                          widget.selectedCategories.remove(category);
                        else
                          widget.selectedCategories.add(category);
                      });
                    }
                  : null,
              child: Chip(
                backgroundColor: widget.selectedCategories.contains(category)
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
          }).toList(),
        ),
        SizedBox(height: 10),
        if (widget.isExpandable)
        TextButton(
            onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExpandedCategories(
                              lesCategories: widget.lesCategories,
                              preSelectedCategories: widget.selectedCategories,
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
