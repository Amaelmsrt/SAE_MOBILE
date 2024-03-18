import 'package:allo/components/CustomTextField.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/utils/bottom_round_clipper.dart';
import 'package:allo/widgets/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: constraints.maxHeight *
                        0.25, // 30% de la hauteur de l'écran
                    child: ClipPath(
                      clipper: BottomRoundClipper(),
                      child: Transform.translate(
                        offset: Offset(0, 0),
                        child: Transform.scale(
                          scale: 1.2,
                          child: Image.asset(
                            'assets/register.png',
                            fit: BoxFit
                                .cover, // remplir le conteneur (peut recadrer l'image)
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 15, 20, 10),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'M\'inscrire',
                            style: TextStyle(
                              fontSize: 28.0,
                              color: AppColors.dark,
                              fontFamily: "NeueRegrade",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomTextField(label: "Nom d'utilisateur", hint: "Nom d'utilisateur...", iconPath: "assets/icons/user.svg"),
                          CustomTextField(label: "E-mail", hint: "E-mail...", iconPath: "assets/icons/email.svg"),
                          CustomTextField(label: "Mot de passe", hint: "Mot de passe...", iconPath: "assets/icons/key.svg"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double buttonWidth = constraints.maxWidth /
                          2.2; // 1.1 (pour le bouton de gauche) + 1.1 * 1.2 (pour le bouton de droite) = 2.2

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width:
                                buttonWidth, // Le bouton de gauche prend 45% de la largeur disponible
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.secondary),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 15.0)),
                                elevation: MaterialStateProperty.all(0.0),
                              ),
                              child: Text(
                                'Connection',
                                style: TextStyle(
                                  color: Color(0xFF0F0D11),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: buttonWidth * 1.2 -
                                10, // Le bouton de droite est 20% plus grand que le bouton de gauche
                            child: ElevatedButton(
                              onPressed: () {
                                print('Button 2');
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.primary),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 15.0)),
                                elevation: MaterialStateProperty.all(0.0),
                              ),
                              child: Text(
                                'Inscription',
                                style: TextStyle(
                                  color: Color(0xFF0F0D11),
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
