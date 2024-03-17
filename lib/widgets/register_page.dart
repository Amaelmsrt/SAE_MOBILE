
import 'package:allo/utils/bottom_round_clipper.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipPath(
                  clipper: BottomRoundClipper(),
                  child: Container(
                    color: Color(0xFFD9D9D9),
                    child: Transform.translate(
                      offset: Offset(10, -55), // décale l'image de 50 pixels vers le haut
                      child: Transform.scale(
                        scale: 1.2, // zoom sur l'image (1.0 est la taille normale)
                        child: Image.asset(
                          'assets/register.png',
                          fit: BoxFit.fill, // remplir le conteneur (peut recadrer l'image)
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 259,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Button 1');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFD4D7EC)),
                      ),
                      child: Text(
                        'Me connecter',
                        style: TextStyle(
                          color: Color(0xFF0F0D11),
                          fontSize: 18.0,
                          fontFamily: "NeueRegrade",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('Button 2');
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    'Créer mon compte',
                    style: TextStyle(
                      color: Color(0xFF0F0D11),
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

