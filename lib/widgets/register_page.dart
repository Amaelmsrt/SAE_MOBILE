import 'dart:async';

import 'package:allo/components/custom_text_field.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/utils/bottom_round_clipper.dart';
import 'package:allo/widgets/login_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final StreamSubscription<AuthState> authSubscription;

  @override
  void initState() {
    super.initState();
    authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        Navigator.of(context).pushReplacementNamed('/acccount');
      }
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    authSubscription.cancel();
    super.dispose();
  }

  Future<void> register(BuildContext context) async {
    final String username = usernameController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    // Print pour vérifier les valeurs des champs
    print('Username: $username');
    print('Email: $email');
    print('Password: $password');

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez remplir tous les champs.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Le mot de passe doit comporter au moins 6 caractères.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Print avant l'appel de signUp
      print(
          'Tentative d\'inscription avec l\'email: $email et le mot de passe: $password');

      final response = await supabase.auth.signUp(email: email, password: password);
      print("Réponse de signUp: $response, user: ${response.user}");
      if (response.user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Veuillez confirmer votre inscription en cliquant sur le lien dans l\'email de confirmation.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final user = supabase.auth.currentUser;
      print('Utilisateur actuel: $user');
      if (user != null) {
        await supabase.from('UTILISATEUR').insert([
          {
            'idUtilisateur': user.id,
            'nomUtilisateur': username,
            'emailUtilisateur': email,
            'mdpUtilisateur': password,
          }
        ]);

        print('Données insérées dans la table UTILISATEUR');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (e) {
      print('Erreur lors de l\'inscription: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur : $e'),
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
                    height: constraints.maxHeight * 0.25,
                    child: ClipPath(
                      clipper: BottomRoundClipper(),
                      child: Transform.translate(
                        offset: Offset(0, 0),
                        child: Transform.scale(
                          scale: 1.2,
                          child: Image.asset(
                            'assets/register.png',
                            fit: BoxFit.cover,
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
                          CustomTextField(
                              controller: usernameController,
                              label: "Nom d'utilisateur",
                              hint: "Nom d'utilisateur...",
                              iconPath: "assets/icons/user.svg"),
                          CustomTextField(
                              controller: emailController,
                              label: "E-mail",
                              hint: "E-mail...",
                              iconPath: "assets/icons/email.svg"),
                          CustomTextField(
                              controller: passwordController,
                              label: "Mot de passe",
                              hint: "Mot de passe...",
                              iconPath: "assets/icons/key.svg",
                              obscureText: true),
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
                                'Connexion',
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
                              onPressed: () => register(context),
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
