import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/index_page_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopSelectionMenu extends StatefulWidget {
  final List<String> items;
  final Function(int) onItemSelected;

  TopSelectionMenu({required this.items, required this.onItemSelected});

  @override
  _TopSelectionMenuState createState() => _TopSelectionMenuState();
}

class _TopSelectionMenuState extends State<TopSelectionMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12, // gap between adjacent chips
          children: this.widget.items.asMap().entries.map<Widget>((entry) {
            int index = entry.key;
            String item = entry.value;

            return GestureDetector(
              onTap: () {
                widget.onItemSelected(index);
                Provider.of<IndexPageNotifications>(context, listen: false)
                    .setIndex(index);
              },
              child: AnimatedContainer(
                padding: EdgeInsets.symmetric(horizontal: 16),
                duration: Duration(milliseconds: 300), // Durée de l'animation
                curve: Curves.easeInOut, // Type d'animation
                decoration: BoxDecoration(
                  color: index == Provider.of<IndexPageNotifications>(context).index
                      ? AppColors.primary
                      : AppColors.lightSecondary,
                  borderRadius: BorderRadius.circular(20),
                  
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "NeueRegrade",
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ));
  }
}
