import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import your color file

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String iconPath;

  CustomTextField({required this.label, required this.hint, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 18.0,
            fontFamily: "NeueRegrade",
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          style: TextStyle(color: AppColors.dark),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors.darkSecondary),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 12.0),
              child: SvgPicture.asset(iconPath),
            ),
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
        SizedBox(height: 24.0),
      ],
    );
  }
}