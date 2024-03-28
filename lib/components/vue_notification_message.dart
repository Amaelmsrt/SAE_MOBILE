import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class VueNotificationMessage extends StatelessWidget {
  String? imagePath;
  String pseudo;
  String message;
  String date;
  int nbNotifs;

  VueNotificationMessage(
      {this.imagePath,
      required this.pseudo,
      required this.message,
      required this.date,
      required this.nbNotifs});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            if (imagePath == null)
              ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  color: AppColors.lightBlue,
                  width: 60, // you can adjust width and height to your liking
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
            SizedBox(width: 13),
            Expanded(
                child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pseudo,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w600,
                        fontFamily: "NeueRegrade",
                      ),
                    ),
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: constraints.maxWidth *
                              0.85, // 70% de la largeur du conteneur
                          child: Text(
                            message,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.darkTertiary,
                                fontFamily: "NeueRegrade",
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      },
                    ),
                    Text(
                      date,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.darkSecondary,
                          fontFamily: "NeueRegrade",
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppColors.notification,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        nbNotifs.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "NeueRegrade",
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )),
          ],
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
