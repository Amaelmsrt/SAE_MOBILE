import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/objet.dart';
import 'package:allo/widgets/expanded_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ObjectPicker extends StatefulWidget {
  final Function onObjectChanged;
  String? label;

  ObjectPicker({
    required this.onObjectChanged,
    this.label,
  });

  @override
  _ObjectPickerState createState() => _ObjectPickerState();
}

class _ObjectPickerState extends State<ObjectPicker> {
  Objet? objet = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (widget.label != null)
          Text(
            widget.label!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontFamily: "NeueRegrade",
              fontWeight: FontWeight.w600,
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (objet != null)
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.lightSecondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: 
          Row(
                                  children: <Widget>[
                                    // affiche l'image de l'objet avec des bords arrondis
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image.asset(
                                        objet!.imagePath,
                                        width: 65,
                                        height: 65,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(objet!.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              fontFamily: "NeueRegrade",
                                              color: AppColors.dark,
                                            )),
                                        Text(objet!.mainCategory,
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
        ),
        TextButton(
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpandedObjects(
                            lesObjets: [
                              Objet(
                                imagePath: "assets/perceuse.jpeg",
                                title: "Perceuse",
                                mainCategory: "Perceuse sans fil",
                              ),
                              Objet(
                                imagePath: "assets/perceuse.jpeg",
                                title: "Visseuse",
                                mainCategory: "Visseuse sans fil",
                              ),
                              Objet(
                                imagePath: "assets/perceuse.jpeg",
                                title: "Marteau",
                                mainCategory: "Marteau",
                              ),
                              Objet(
                                imagePath: "assets/perceuse.jpeg",
                                title: "Scie",
                                mainCategory: "Scie",
                              ),
                            ],
                            onObjectChanged: (Objet? obj) {
                              setState(() {
                                objet = obj;
                                widget.onObjectChanged(obj!);
                              });
                            }),
                      ))
                },
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.zero),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  objet == null ? "Choisir un objet" : "Modifier l'objet",
                  style: TextStyle(
                    fontFamily: "NeueRegrade",
                    color: AppColors.accent,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                SvgPicture.asset(
                  "assets/icons/plus.svg",
                  height: 15,
                )
              ],
            ))
      ],
    );
  }
}
