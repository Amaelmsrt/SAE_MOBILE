import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import your color file

class CustomDatePicker extends StatefulWidget {
  final String? label;
  final String hint;
  final bool noSpacing;

  CustomDatePicker({this.label, required this.hint, this.noSpacing = false});

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null)
          Text(
            widget.label!,
            style: TextStyle(
              color: AppColors.dark,
              fontSize: 18.0,
              fontFamily: "NeueRegrade",
              fontWeight: FontWeight.w600,
            ),
          ),
        if (widget.label != null) SizedBox(height: 16.0),
        GestureDetector(
          onTap: () async {
            FocusScope.of(context)
                .requestFocus(new FocusNode()); // to hide the keyboard
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor:
                        AppColors.accent, //Change this to your desired color
                    colorScheme: ColorScheme.light(
                        primary:
                            AppColors.accent), //Change this to your desired color
                    buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null && picked != selectedDate) {
              setState(() {
                selectedDate = picked;
              });
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: TextEditingController(
                  text: "${selectedDate.toLocal()}".split(' ')[0]),
              style: TextStyle(color: AppColors.dark),
              decoration: InputDecoration(
                hintText: widget.hint,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
                hintStyle: TextStyle(color: AppColors.darkSecondary),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 12.0),
                  child: SvgPicture.asset("assets/icons/cal.svg"),
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
          ),
        ),
        if (widget.noSpacing == false) SizedBox(height: 24.0),
      ],
    );
  }
}
