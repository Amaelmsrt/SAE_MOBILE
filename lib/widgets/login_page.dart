import 'package:allo/constants/app_colors.dart';
import 'package:allo/utils/bottom_round_clipper.dart';
import 'package:allo/widgets/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
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
                        0.4, // 30% de la hauteur de l'écran
                    child: ClipPath(
                      clipper: BottomRoundClipper(),
                      child: Transform.translate(
                        offset: Offset(0, 0),
                        child: Transform.scale(
                          scale: 1.2,
                          child: Image.asset(
                            'assets/login.png',
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
                            'Me connecter',
                            style: TextStyle(
                              fontSize: 28.0,
                              color: AppColors.dark,
                              fontFamily: "NeueRegrade",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                              height:
                                  32.0), // espace entre le titre et le premier champ de texte
                          Text(
                            "Nom d'utilisateur",
                            style: TextStyle(
                              color: AppColors.dark,
                              fontSize: 18.0,
                              fontFamily: "NeueRegrade",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                              height:
                                  16.0), // espace entre le titre et le premier champ de texte
                          TextField(
                            style: TextStyle(color: AppColors.dark),
                            decoration: InputDecoration(
                              hintText: "Nom d'utilisateur...",
                              hintStyle:
                                  TextStyle(color: AppColors.darkSecondary),
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 12.0),
                                child: SvgPicture.asset(
                                  'assets/icons/user.svg',
                                ),
                              ), // Icon on the left
                              filled: true, // To change the background
                              fillColor:
                                  AppColors.lightSecondary, // Background color
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30.0)), // Rounded outline
                                borderSide: BorderSide(
                                    color: AppColors.primary), // Border color
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30.0)), // Rounded outline
                                borderSide: BorderSide(
                                    color:
                                        AppColors.accent), // Focus border color
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  24.0), // espace entre le dernier champ de texte et les boutons
                          Text(
                            'Mot de passe',
                            style: TextStyle(
                              color: AppColors.dark,
                              fontSize: 18.0,
                              fontFamily: "NeueRegrade",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                              height:
                                  16.0), // espace entre le titre et le premier champ de texte
                          TextField(
                            style: TextStyle(color: AppColors.dark),
                            decoration: InputDecoration(
                              hintText: 'Mot de passe...',
                              hintStyle:
                                  TextStyle(color: AppColors.darkSecondary),
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 12.0),
                                child: SvgPicture.asset(
                                  'assets/icons/key.svg',
                                ),
                              ), // Icon on the left
                              filled: true, // To change the background
                              fillColor:
                                  AppColors.lightSecondary, // Background color
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30.0)), // Rounded outline
                                borderSide: BorderSide(
                                    color: AppColors.primary), // Border color
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(30.0)), // Rounded outline
                                borderSide: BorderSide(
                                    color:
                                        AppColors.accent), // Focus border color
                              ),
                            ),
                          ),
                          SizedBox(height: 24.0),
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
                                      builder: (context) => RegisterPage()),
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
                                'Inscription',
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
                                'Me connecter',
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
