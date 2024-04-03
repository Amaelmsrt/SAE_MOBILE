import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/Utilisateur.dart';
import 'package:allo/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VueMessage extends StatefulWidget {
  // pour tous les messages
  Utilisateur utilisateur;
  final int typeMessage;
  String content;
  String date;
  bool estVu;
  bool isMine;

  // for avis message
  bool? avisLaisse;

  // for aide message;
  bool? aRepondu;
  bool? reponse;

  VueMessage.forDefault({
    required this.utilisateur,
    this.content =
        "Le commentaire de l’autre qui souhaite t’aider car il a vu que il pourrait être intéréssé pour t'aider hihihi",
    this.date = "Il y a 4 minutes.",
    this.estVu = false,
    this.isMine = false,
  }) : typeMessage = Message.DEFAULT; // Default value

  VueMessage.forAvis({
    required this.utilisateur,
    this.avisLaisse = false,
    this.content =
        "Le commentaire de l’autre qui souhaite t’aider car il a vu que il pourrait être intéréssé pour t'aider hihihi",
    this.date = "Il y a 4 minutes.",
    this.estVu = false,
    this.isMine = false,
  }) : typeMessage = Message.AVIS; // Value for Avis

  VueMessage.forAide({
    required this.utilisateur,
    this.aRepondu = false,
    this.reponse = false,
    this.content =
        "Le commentaire de l’autre qui souhaite t’aider car il a vu que il pourrait être intéréssé pour t'aider hihihi",
    this.date = "Il y a 4 minutes.",
    this.estVu = false,
    this.isMine = false,
  }) : typeMessage = Message.AIDE; // Value for Aide

  @override
  _vueMessageState createState() => _vueMessageState();
}

class _vueMessageState extends State<VueMessage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        FractionallySizedBox(
          widthFactor:
              1.0, // This will make the Container take all available width
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.typeMessage == Message.AIDE ||
                      widget.typeMessage == Message.AVIS
                  ? AppColors.lightSecondary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: widget.isMine
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: (widget.isMine ? [
                    if (widget.utilisateur.photoDeProfilUtilisateur == null &&
                        widget.typeMessage != Message.AVIS)
                      ClipOval(
                        child: Container(
                          alignment: Alignment.center,
                          color: AppColors.lightBlue,
                          width:
                              30, // you can adjust width and height to your liking
                          height:
                              30, // you can adjust width and height to your liking
                          child: Text(
                            widget.utilisateur.nomUtilisateur[0].toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              fontFamily: "NeueRegrade",
                            ),
                          ),
                        ),
                      ),
                    if (widget.utilisateur.photoDeProfilUtilisateur != null &&
                        widget.typeMessage != Message.AVIS)
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: MemoryImage(
                                widget.utilisateur.photoDeProfilUtilisateur!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    SizedBox(width: 13),
                    if (widget.typeMessage != Message.DEFAULT)
                      Flexible(
                        child: Text(
                          "Le commentaire de l’autre qui souhaite t’aider car il a vu que il pourrait être intéréssé pour t'aider hihihi",
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    if (widget.typeMessage == Message.DEFAULT)
                      Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: widget.isMine
                              ? AppColors.lightBlue
                              : AppColors.lightSecondary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Flexible(
                          child: Text(
                            "Le commentaire de l’autre qui souhaite t’aider car il a vu que il pourrait être intéréssé pour t'aider hihihi",
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                  ].reversed.toList() : [
                    if (widget.utilisateur.photoDeProfilUtilisateur == null &&
                        widget.typeMessage != Message.AVIS)
                      ClipOval(
                        child: Container(
                          alignment: Alignment.center,
                          color: AppColors.lightBlue,
                          width:
                              30, // you can adjust width and height to your liking
                          height:
                              30, // you can adjust width and height to your liking
                          child: Text(
                            widget.utilisateur.nomUtilisateur[0].toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              fontFamily: "NeueRegrade",
                            ),
                          ),
                        ),
                      ),
                    if (widget.utilisateur.photoDeProfilUtilisateur != null &&
                        widget.typeMessage != Message.AVIS)
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: MemoryImage(
                                widget.utilisateur.photoDeProfilUtilisateur!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    SizedBox(width: 13),
                    if (widget.typeMessage != Message.DEFAULT)
                      Flexible(
                        child: Text(
                          "Le commentaire de l’autre qui souhaite t’aider car il a vu que il pourrait être intéréssé pour t'aider hihihi",
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    if (widget.typeMessage == Message.DEFAULT)
                      Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: widget.isMine
                              ? AppColors.lightBlue
                              : AppColors.lightSecondary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Flexible(
                          child: Text(
                            "Le commentaire de l’autre qui souhaite t’aider car il a vu que il pourrait être intéréssé pour t'aider hihihi",
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                  ]),
                ),
                SizedBox(
                  height: widget.typeMessage == Message.DEFAULT ? 0 : 32,
                ),
                if (widget.typeMessage == Message.AVIS)
                  Row(
                    children: [
                      if (widget.avisLaisse == false)
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.avisLaisse = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              elevation: 0,
                              backgroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Text(
                              'Laisser un avis',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NeueRegrade",
                                color: AppColors.dark,
                              ),
                            ),
                          ),
                        ),
                      if (widget.avisLaisse == true)
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text(
                                "Vous avez laissé un avis.",
                                style: TextStyle(
                                  color: AppColors.dark,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "NeueRegrade",
                                ),
                              ),
                              SizedBox(width: 10),
                              SvgPicture.asset("assets/icons/check.svg"),
                            ],
                          ),
                        )
                    ],
                  ),
                if (widget.typeMessage == Message.AIDE &&
                    widget.aRepondu == false)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.aRepondu = true;
                              widget.reponse = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            elevation: 0,
                            backgroundColor: AppColors.lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            'Refuser',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "NeueRegrade",
                              color: AppColors.dark,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              widget.aRepondu = true;
                              widget.reponse = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 25),
                            elevation: 0,
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            'Accepter',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "NeueRegrade",
                              color: AppColors.dark,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                if (widget.typeMessage == Message.AIDE &&
                    widget.aRepondu == true)
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(
                          "Vous avez ${widget.reponse == true ? "accepté" : "refusé"} cette proposition d'aide.",
                          style: TextStyle(
                            color: AppColors.dark,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: "NeueRegrade",
                          ),
                        ),
                        SizedBox(width: 10),
                        SvgPicture.asset("assets/icons/check.svg"),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment:
              widget.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: (!widget.isMine
                  ? [
                      SvgPicture.asset("assets/icons/check.svg"),
                      SizedBox(width: 10),
                      Text(
                        "Il y a 4 minutes.",
                        style: TextStyle(
                          color: AppColors.dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "NeueRegrade",
                        ),
                      ),
                    ]
                  : [
                      Text(
                        "Il y a 4 minutes.",
                        style: TextStyle(
                          color: AppColors.dark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "NeueRegrade",
                        ),
                      ),
                      SizedBox(width: 10),
                      SvgPicture.asset("assets/icons/check.svg"),
                    ])
              .reversed
              .toList(),
        )
      ],
    );
  }
}
