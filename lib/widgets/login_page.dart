import 'package:allo/components/custom_text_field.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/main.dart';
import 'package:allo/models/DB/user_bd.dart';
import 'package:allo/models/utilisateur.dart';
import 'package:allo/models/my_user.dart';
import 'package:allo/utils/bottom_round_clipper.dart';
import 'package:allo/widgets/home.dart';
import 'package:allo/widgets/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart' as provider;

class LoginPage extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    try {
      final response = await supabase.auth.signInWithPassword(
          password: _passwordController.text, email: _usernameController.text);
      print(response.user);
      print(response.session);

      if (response.user != null) {
        Utilisateur user = await UserBD.getMyUser();
        provider.Provider.of<MyUser>(context, listen: false).setMyUser(user);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      String errorMessage;
      if (e is AuthException) {
        errorMessage = 'Email ou mot de passe invalide';
      } else {
        errorMessage = 'Une autre erreur s\'est produite: $e';
      }
      print(errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
                          CustomTextField(
                            label: "E-mail",
                            hint: "E-mail...",
                            iconPath: "assets/icons/email.svg",
                            controller: _usernameController,
                          ),
                          CustomTextField(
                            label: "Mot de passe",
                            hint: "Mot de passe...",
                            iconPath: "assets/icons/key.svg",
                            controller: _passwordController,
                            obscureText: true,
                          ),
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
                                login(context);
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
