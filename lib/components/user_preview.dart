import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserPreview extends StatelessWidget {
  String? imagePath;
  String pseudo;
  int nbEtoiles;
  int nbAvis;

  String? description;

  UserPreview(
      {this.imagePath,
      required this.pseudo,
      required this.nbEtoiles,
      required this.nbAvis,
      this.description});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             if (description != null && description!.isNotEmpty)
            Text(
              description!,
              style: TextStyle(
              color: AppColors.dark,
              fontSize: 18.0,
              fontFamily: "NeueRegrade",
              fontWeight: FontWeight.w600,
            ),
            ),
          if (description != null && description!.isNotEmpty)
            SizedBox(height: 16),
            Container(
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.lightSecondary,
            borderRadius: BorderRadius.circular(10000),
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (imagePath == null)
                        ClipOval(
                          child: Container(
                            alignment: Alignment.center,
                            color: AppColors.lightBlue,
                            width:
                                60, // you can adjust width and height to your liking
                            height:
                                60, // you can adjust width and height to your liking
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
                      if (imagePath != null)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(imagePath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      SizedBox(
                          width:
                              10), // you can adjust the spacing to your liking
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(pseudo),
                          Row(children: <Widget>[
                            SvgPicture.asset("assets/icons/star.svg", color: nbEtoiles >= 1 ? AppColors.yellow : AppColors.lightBlue,),
                            SvgPicture.asset("assets/icons/star.svg", color: nbEtoiles >= 2 ? AppColors.yellow : AppColors.lightBlue),
                            SvgPicture.asset("assets/icons/star.svg", color: nbEtoiles >= 3 ? AppColors.yellow : AppColors.lightBlue),
                            SvgPicture.asset("assets/icons/star.svg", color: nbEtoiles >= 4 ? AppColors.yellow : AppColors.lightBlue),
                            SvgPicture.asset("assets/icons/star.svg", color: nbEtoiles >= 5 ? AppColors.yellow : AppColors.lightBlue),
                            SizedBox(width: 8),
                            Text('${nbAvis} avis')
                          ])
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50, // same height as a FAB
                      width: 50, // same width as a FAB
                      decoration: BoxDecoration(
                        color: AppColors.primary, // same color as your FAB
                        borderRadius: BorderRadius.circular(
                            8000), // change this to your desired border radius
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                            "assets/icons/chat.svg"), // your icon
                      ),
                    ),
                  ),
                ],
              ))),
        )
          ],
        ) 
      );
  }
}
