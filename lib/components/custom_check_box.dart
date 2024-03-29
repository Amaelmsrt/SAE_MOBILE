import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import your color file

class CustomCheckBox extends StatefulWidget {
  final String? label;
  final String hint;
  final bool noSpacing;
  bool isChecked;
  final ValueNotifier<bool>? isCheckedNotifier;

  CustomCheckBox(
      {this.label,
      required this.hint,
      this.noSpacing = false,
      this.isChecked = false,
      required this.isCheckedNotifier
      });

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
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
          onTap: () {
            setState(() {
              widget.isChecked = !widget.isChecked;
              if (widget.isCheckedNotifier != null) {
                widget.isCheckedNotifier!.value = widget.isChecked;
              }
            });
          },
          child: Row(
            children: [
              Checkbox(
                activeColor: AppColors.accent,
                value: widget.isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    widget.isChecked = value!;
                  });
                },
              ),
              Text(
                widget.hint,
                style: TextStyle(
                  color: AppColors.dark,
                  fontSize: 16.0,
                  fontFamily: "NeueRegrade",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (widget.noSpacing == false) SizedBox(height: 24.0),
      ],
    );
  }
}
