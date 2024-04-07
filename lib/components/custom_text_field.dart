import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/decimal_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import your color file

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final String? iconPath;
  final bool isArea;
  final bool noSpacing;
  final TextEditingController? controller;
  final bool obscureText;
  final String? sideButtonIconPath;
  final Function()? sideButtonOnPressed;
  final bool isPrice;
  CustomTextField(
      {this.label,
      required this.hint,
      this.iconPath,
      this.controller,
      this.obscureText = false,
      this.isArea = false,
      this.noSpacing = false,
      this.sideButtonIconPath = null,
      this.sideButtonOnPressed,
      this.isPrice = false,
      });

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
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: isPrice ? TextInputType.numberWithOptions(decimal: true) : TextInputType.text,
                inputFormatters: isPrice ? [DecimalInputFormatter()] : [],
                controller: controller,
                obscureText: obscureText,
                minLines: this.isArea ? 5 : 1,
                maxLines: this.isArea ? 5 : 1,
                style: TextStyle(color: AppColors.dark),
                decoration: InputDecoration(
                  suffixText: isPrice ? "€" : null,
                  hintText: hint,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
                  hintStyle: TextStyle(color: AppColors.darkSecondary),
                  prefixIcon: iconPath != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 12.0),
                          child: SvgPicture.asset(iconPath!),
                        )
                      : null,
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
            ),
            if (sideButtonIconPath != null)
              SizedBox(width: 8.0),   
            if (sideButtonIconPath != null)
              Positioned(
                    top: 17,
                    child: InkWell(
                      onTap: () {
                        this.sideButtonOnPressed!();
                      },
                      child: Container(
                        height: 57, // same height as a FAB
                        width: 57, // same width as a FAB
                        decoration: BoxDecoration(
                          color: AppColors.primary, // same color as your FAB
                          borderRadius: BorderRadius.circular(
                              8000), // change this to your desired border radius
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                              this.sideButtonIconPath!), // your icon
                        ),
                      ),
                    ),
                  ),
          ],
        ),
        if (this.noSpacing == false) SizedBox(height: 24.0),
      ],
    );
  }
}
