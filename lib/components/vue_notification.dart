import 'package:flutter/material.dart';

class VueNotification extends StatelessWidget {
  final String imagePath;
  final String titreAnnonce;
  final String date;
  final String intitule;

  VueNotification(
      {required this.imagePath,
      required this.titreAnnonce,
      required this.date,
      required this.intitule});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // à gauche l'image à droite le titre de l'annonce et en dessous la date
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      titreAnnonce,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: "NeueRegrade",
                      ),
                    ),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: "NeueRegrade",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          intitule,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: "NeueRegrade",
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}
