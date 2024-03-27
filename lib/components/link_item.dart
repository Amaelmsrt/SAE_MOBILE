import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LinkItem extends StatelessWidget{
  String title;
  //fonction qui sera appelée lorsqu'on clique sur le lien
  Function() onTap;

  LinkItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: AppColors.lightSecondary,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Container(
        padding: new EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.darkQuaternary,
              ),
            ),
            SvgPicture.asset("assets/icons/chevron-right.svg"),
          ]
        ),
      ),
    ),
  );
  }
}