import 'dart:typed_data';

import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ResumeAnnonce extends StatelessWidget{
  Uint8List image;
  String title;
  String description;

  ResumeAnnonce({required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightSecondary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // affiche l'image de l'objet avec des bords arrondis
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.memory(
                  image,
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12,),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: "NeueRegrade",
                          color: AppColors.dark,
                        )),
                    Text(description,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          fontFamily: "NeueRegrade",
                          color: AppColors.dark,
                        )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}