import 'package:allo/widgets/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    FlutterStatusbarcolor.setNavigationBarColor(Colors.white, animate: true);
    
    return MaterialApp(
      home: WelcomePage(),
    );
  }
}