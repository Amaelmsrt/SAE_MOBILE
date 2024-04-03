import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/user_preview.dart';
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
          Container(
            color: Colors.white,
            child: Center(
              child: Text(
                'Page de conversation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
                        child:
                            UserPreview(utilisateur: utilisateur, isTop: true),
                      );
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
                    child: CustomTextField(hint: "Ecrivez votre message...", iconPath: "assets/icons/bulle-message.svg",
                      sideButtonIconPath: "assets/icons/send-message.svg", sideButtonOnPressed: () {
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
