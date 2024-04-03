import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/resume_annonce.dart';
import 'package:allo/components/user_preview.dart';
import 'package:allo/components/vue_message.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/message_bd.dart';
import 'package:allo/models/Utilisateur.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/message.dart';
import 'package:allo/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PageConversation extends StatefulWidget {
  Utilisateur utilisateur;
  Annonce annonce;
  Message? preloadedMessage;

  PageConversation(
      {required this.utilisateur,
      required this.annonce,
      this.preloadedMessage});

  @override
  State<PageConversation> createState() => _PageConversationState();
}

class _PageConversationState extends State<PageConversation> {
  @override
  Widget build(BuildContext context) {
    late Future<List<Message>> lesMessages =
        MessageBD.getMessages(idAnnonce: widget.annonce.idAnnonce);

    TextEditingController controllerText = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.light,
      body: Stack(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: 230, bottom: 100, left: 15, right: 15),
            child: Container(
              color: Colors.transparent,
              child: FutureBuilder<List<Message>>(
                future: lesMessages,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Erreur de connexion"),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Message message = snapshot.data![index];
                      if (message.typeMessage == Message.DEFAULT) {
                        return VueMessage.forDefault(
                          utilisateur: message.isMine
                              ? Provider.of<MyUser>(context, listen: false)
                                  .myUser!
                              : widget.utilisateur,
                          content: message.contenu,
                          isMine: message.isMine,
                          date: message.dateMessage.toString(),
                          estVu: message.estVu,
                        );
                      } else if (message.typeMessage == Message.AIDE) {
                        return VueMessage.forAide(
                          utilisateur: message.isMine
                              ? Provider.of<MyUser>(context, listen: false)
                                  .myUser!
                              : widget.utilisateur,
                          aRepondu: message.estRepondu,
                          reponse: message.estAccepte,
                          content: message.contenu,
                          isMine: message.isMine,
                          date: message.dateMessage.toString(),
                          estVu: message.estVu,
                          idAnnonce: message.annonceConcernee!.idAnnonce,
                        );
                      } else {
                        // a faire
                        return Container();
                        //return VueMessage.forAvis(utilisateur: utilisateur, avisLaisse: message,)
                      }
                    },
                  );
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
                                  utilisateur: widget.utilisateur, isTop: true),
                              SizedBox(
                                height: 10,
                              ),
                              ResumeAnnonce(
                                  image: widget.annonce.images[0],
                                  title: widget.annonce
                                      .titreAnnonce, // Replace with your annonce object
                                  description: widget.annonce.getEtatStr())
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
                      controller: controllerText,
                      sideButtonOnPressed: () {
                        if (controllerText.text.isNotEmpty) {
                          MessageBD.sendMessage(
                                  idAnnonce: widget.annonce.idAnnonce,
                                  contenu: controllerText.text,
                                  idReceveur: widget.utilisateur.idUtilisateur)
                              .then((_) {
                            setState(() {
                              controllerText.clear();
                              lesMessages = MessageBD.getMessages(
                                  idAnnonce: widget.annonce.idAnnonce);
                            });
                          });
                        }
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
