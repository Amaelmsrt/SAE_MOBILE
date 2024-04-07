import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/message.dart';
import 'package:allo/models/my_user.dart';
import 'package:allo/widgets/page_conversation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VueNotificationMessage extends StatelessWidget {
  Message message;
  int nbNotifs;

  VueNotificationMessage({required this.message, required this.nbNotifs});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: PageConversation(utilisateur: message.isMine
                    ? message.utilisateurReceveur!
                    : message.utilisateurEnvoyeur!, annonce: message.annonceConcernee!, preloadedMessage: message),
              ),
            ),
          );
        },
        child: Column(
          children: [
            Row(
              children: [
                if (message.isMine &&
                        message.utilisateurReceveur!.photoDeProfilUtilisateur ==
                            null ||
                    !message.isMine &&
                        message.utilisateurEnvoyeur!.photoDeProfilUtilisateur ==
                            null)
                  ClipOval(
                    child: Container(
                      alignment: Alignment.center,
                      color: AppColors.lightBlue,
                      width:
                          60, // you can adjust width and height to your liking
                      height:
                          60, // you can adjust width and height to your liking
                      child: Text(
                        message.isMine
                            ? message.utilisateurReceveur!
                                .nomUtilisateur[0]
                                .toUpperCase()
                            : message.utilisateurEnvoyeur!.nomUtilisateur[0]
                                .toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          fontFamily: "NeueRegrade",
                        ),
                      ),
                    ),
                  ),
                if (message.isMine &&
                        message.utilisateurReceveur!.photoDeProfilUtilisateur !=
                            null ||
                    !message.isMine &&
                        message.utilisateurEnvoyeur!.photoDeProfilUtilisateur !=
                            null)
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: MemoryImage(message.isMine
                            ? message.utilisateurReceveur!
                                .photoDeProfilUtilisateur!
                            : message.utilisateurEnvoyeur!
                                .photoDeProfilUtilisateur!),
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
                          message.isMine
                              ? message
                                  .utilisateurReceveur!.nomUtilisateur
                              : message.utilisateurEnvoyeur!.nomUtilisateur,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.dark,
                            fontWeight: FontWeight.w600,
                            fontFamily: "NeueRegrade",
                          ),
                        ),
                        LayoutBuilder(
                          builder: (BuildContext context,
                              BoxConstraints constraints) {
                            return Container(
                              width: constraints.maxWidth *
                                  0.85, // 70% de la largeur du conteneur
                              child: Text(
                                message.annonceConcernee!.titreAnnonce,
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
                          message.contenu,
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.darkSecondary,
                              fontFamily: "NeueRegrade",
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    if (nbNotifs > 0)
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
        ));
  }
}
