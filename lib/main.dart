import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
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
                    child: Image.asset(
                      'assets/main.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 45.0, // Ajustez la position verticale selon votre besoin
                  child: Center(
                    child: Text(
                      'Bienvenue sur ALL\'O',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        fontFamily: "NeueRegrade",
                        fontWeight: FontWeight.bold,
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

class BottomRoundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 60);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}