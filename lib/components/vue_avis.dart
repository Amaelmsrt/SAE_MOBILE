import 'dart:typed_data';

import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class VueAvis extends StatelessWidget {
  Uint8List? image;
  String pseudo, commentaire, date;
  int nbEtoiles;

  VueAvis({
    this.image,
    required this.pseudo,
    required this.commentaire,
    required this.date,
    required this.nbEtoiles,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (image == null)
          ClipOval(
            child: Container(
              alignment: Alignment.center,
              color: AppColors.lightBlue,
              width: 60, // you can adjust width and height to your liking
              height: 60, // you can adjust width and height to your liking
              child: Text(
                pseudo[0].toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  fontFamily: "NeueRegrade",
                ),
              ),
            ),
          ),
        if (image != null)
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: MemoryImage(image!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(pseudo,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: "NeueRegrade",
                      color: AppColors.dark,
                    )
                  ),
                   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset("assets/icons/star.svg", height: 16, color: nbEtoiles >= 1 ? AppColors.yellow : AppColors.primary),
                  SvgPicture.asset("assets/icons/star.svg", height: 16, color: nbEtoiles >= 2 ? AppColors.yellow : AppColors.primary),
                  SvgPicture.asset("assets/icons/star.svg", height: 16, color: nbEtoiles >= 3 ? AppColors.yellow : AppColors.primary),
                  SvgPicture.asset("assets/icons/star.svg", height: 16, color: nbEtoiles >= 4 ? AppColors.yellow : AppColors.primary),
                  SvgPicture.asset("assets/icons/star.svg", height: 16, color: nbEtoiles >= 5 ? AppColors.yellow : AppColors.primary),
                ]),
                ],
              ),
              SizedBox(height: 0,),
              Text(commentaire, style: TextStyle(
                color: AppColors.darkSecondary,
                fontSize: 16,
                fontFamily: "NeueRegrade",
                fontWeight: FontWeight.w500,
              )),
              SizedBox(height: 8,),
              Text(date, style: 
              TextStyle(
                color: AppColors.darkQuaternary,
                fontSize: 16,
              ),)
            ],
          ),
        )
      ],
    );
  }
}