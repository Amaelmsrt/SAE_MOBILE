import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarPicker extends StatefulWidget {
  final Function(int) onRatingChanged;
  String? label;

  StarPicker({
    required this.onRatingChanged,
    this.label,
  });

  @override
  _StarPickerState createState() => _StarPickerState();
}

class _StarPickerState extends State<StarPicker> {
  int _rating = 0;

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
        Row(
          children: <Widget>[
            for (int i = 1; i <= 5; i++)
              IconButton(
                color: i > _rating ? AppColors.yellow : AppColors.accent,
                icon: SvgPicture.asset("assets/icons/star.svg",
                height: 36,
                color: i <= _rating ? AppColors.yellow : AppColors.lightBlue,
                ),
                onPressed: () {
                  setState(() {
                    _rating = i;
                    widget.onRatingChanged(_rating);
                  });
                },
              ),
          ],
        ),
      ],
    );
  }
}