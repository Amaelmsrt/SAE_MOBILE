import 'package:allo/main.dart';
import 'package:allo/models/DB/user_bd.dart';
import 'package:allo/models/Utilisateur.dart';
import 'package:allo/models/my_user.dart';
import 'package:allo/widgets/home.dart';
import 'package:allo/widgets/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    if (supabase.auth.currentUser != null) {
      Utilisateur user = await UserBD.getMyUser();
      Provider.of<MyUser>(context, listen: false).setMyUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setNavigationBarColor(Colors.white, animate: true);

    return MaterialApp(
      home: Builder(
        builder: (BuildContext context) {
          if (supabase.auth.currentUser != null) {
            return Home();
          } else {
            return WelcomePage();
          }
        },
      ),
    );
  }
}