import 'package:allo/constants/app_colors.dart';
import 'package:flutter/material.dart';

class VueGestionObjetAnnonce extends StatefulWidget {
  String imagePath;
  String titre;
  String description;
  Color couleurEtat;
  String etat;
  String action;
  Function actionFunction;

  VueGestionObjetAnnonce(
      {required this.imagePath,
      required this.titre,
      required this.description,
      required this.couleurEtat,
      required this.etat,
      required this.action,
      required this.actionFunction});

  @override
  _VueGestionObjetAnnonceState createState() => _VueGestionObjetAnnonceState();
}

class _VueGestionObjetAnnonceState extends State<VueGestionObjetAnnonce> {
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
                child: Image.asset(
                  widget.imagePath,
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.titre,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: "NeueRegrade",
                        color: AppColors.dark,
                      )),
                  Text(widget.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: "NeueRegrade",
                        color: AppColors.dark,
                      )),
                ],
              )
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  widget.actionFunction();
                },
                child: AnimatedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  duration: Duration(milliseconds: 300), // Durée de l'animation
                  curve: Curves.easeInOut, // Type d'animation
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      widget.action,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "NeueRegrade",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8,),
              GestureDetector(
                onTap: () {},
                child: AnimatedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  duration: Duration(milliseconds: 300), // Durée de l'animation
                  curve: Curves.easeInOut, // Type d'animation
                  decoration: BoxDecoration(
                    color: widget.couleurEtat,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      widget.etat,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "NeueRegrade",
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
