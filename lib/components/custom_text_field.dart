import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import your color file

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final String? iconPath;
  final bool isArea;
  final bool noSpacing;

  CustomTextField({this.label, required this.hint, this.iconPath, this.isArea = false, this.noSpacing = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label != null)
          Text(
            label!,
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 18.0,
              fontFamily: "NeueRegrade",
              fontWeight: FontWeight.w600,
            ),
          ),
        if (label != null) SizedBox(height: 16.0),
        TextField(
          minLines: this.isArea ? 5 : 1,
          maxLines: this.isArea ? 5 : 1,
          style: TextStyle(color: AppColors.dark),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
            hintStyle: TextStyle(color: AppColors.darkSecondary),
            prefixIcon: iconPath != null ? Padding(
              padding: EdgeInsets.only(left: 20.0, right: 12.0),
              child: SvgPicture.asset(iconPath!),
            ) : null,
            filled: true,
            fillColor: AppColors.lightSecondary,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(color: AppColors.accent),
            ),
          ),
        ),
        if (this.noSpacing == false)
          SizedBox(height: 24.0),
      ],
    );
  }
}