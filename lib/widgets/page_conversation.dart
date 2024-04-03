import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/resume_annonce.dart';
import 'package:allo/components/user_preview.dart';
import 'package:allo/components/vue_message.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/Utilisateur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageConversation extends StatelessWidget {
  Utilisateur utilisateur;

  PageConversation({required this.utilisateur});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      body: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: 230, bottom: 100, left: 15, right: 15),
            child: Container(
              color: Colors.transparent,
              child: ListView.builder(
                reverse: true,
                itemCount:
                    20, // Replace with your list of messages
                itemBuilder: (context, index) {
                  return index % 3 == 0 ? VueMessage.forDefault(utilisateur: utilisateur,) : index % 2 == 0 ? VueMessage.forAide(utilisateur: utilisateur) : VueMessage.forAvis(utilisateur: utilisateur); // Replace with your message object
                },
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 25,
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return Positioned(
                          top: 45,
                          left: constraints.maxWidth / 2 -
                              45 / 2, // Center horizontally
                          child: Column(
                            children: [
                              UserPreview(
                                  utilisateur: utilisateur, isTop: true),
                              SizedBox(
                                height: 10,
                              ),
                              ResumeAnnonce(
                                  image: utilisateur.photoDeProfilUtilisateur!,
                                  title:
                                      "Besoin d'une perceuse pour le 24/07/0245",
                                  description: "perceuse")
                            ],
                          ));
                    },
                  ),
                  Positioned(
                    top: 17,
                    child: InkWell(
                      onTap: () {
                        print("Back");
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 45, // same height as a FAB
                        width: 45, // same width as a FAB
                        decoration: BoxDecoration(
                          color: AppColors.primary, // same color as your FAB
                          borderRadius: BorderRadius.circular(
                              8000), // change this to your desired border radius
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                              "assets/icons/arrow-back.svg"), // your icon
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomTextField(
                      hint: "Ecrivez votre message...",
                      iconPath: "assets/icons/bulle-message.svg",
                      sideButtonIconPath: "assets/icons/send-message.svg",
                      sideButtonOnPressed: () {
                        // Send message
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
