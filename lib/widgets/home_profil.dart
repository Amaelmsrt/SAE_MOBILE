import 'dart:typed_data';

import 'package:allo/components/link_item.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/main.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/my_user.dart';
import 'package:allo/widgets/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeProfil extends StatefulWidget {
  @override
  State<HomeProfil> createState() => _HomeProfilState();
}

class _HomeProfilState extends State<HomeProfil> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppBarTitle>(context, listen: false).setTitle('Mon profil');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: new EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              if (Provider.of<MyUser>(context).myUser?.photoDeProfilUtilisateur == null)
                ClipOval(
                  child: Container(
                    alignment: Alignment.center,
                    color: AppColors.lightBlue,
                    width: 130, // you can adjust width and height to your liking
                    height:
                        130, // you can adjust width and height to your liking
                    child: Text(
                      Provider.of<MyUser>(context).myUser?.nomUtilisateur[0].toUpperCase() ?? "?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        fontFamily: "NeueRegrade",
                      ),
                    ),
                  ),
                ),
              if (Provider.of<MyUser>(context).myUser?.photoDeProfilUtilisateur != null)
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: MemoryImage(Provider.of<MyUser>(context).myUser?.photoDeProfilUtilisateur! ?? Uint8List(0)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(
                height: 16,
              ),
              Text(
                Provider.of<MyUser>(context).myUser?.nomUtilisateur ??
                    'aucun utilisateur',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  fontFamily: "NeueRegrade",
                  color: AppColors.dark,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/icons/star.svg",
                      height: 16,
                      color:
                          ((Provider.of<MyUser>(context).myUser?.note ?? 0) >= 1
                              ? AppColors.yellow
                              : AppColors.primary),
                    ),
                    SvgPicture.asset("assets/icons/star.svg",
                        height: 16,
                        color:
                            ((Provider.of<MyUser>(context).myUser?.note ?? 0) >=
                                    2
                                ? AppColors.yellow
                                : AppColors.primary)),
                    SvgPicture.asset("assets/icons/star.svg",
                        height: 16,
                        color:
                            ((Provider.of<MyUser>(context).myUser?.note ?? 0) >=
                                    3
                                ? AppColors.yellow
                                : AppColors.primary)),
                    SvgPicture.asset("assets/icons/star.svg",
                        height: 16,
                        color:
                            ((Provider.of<MyUser>(context).myUser?.note ?? 0) >=
                                    4
                                ? AppColors.yellow
                                : AppColors.primary)),
                    SvgPicture.asset("assets/icons/star.svg",
                        height: 16,
                        color:
                            ((Provider.of<MyUser>(context).myUser?.note ?? 0) >=
                                    5
                                ? AppColors.yellow
                                : AppColors.primary)),
                    SizedBox(width: 8),
                    Text(
                      (Provider.of<MyUser>(context).myUser?.nbAvis.toString() ??
                              '0') +
                          " avis",
                      style: TextStyle(
                        color: AppColors.dark,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        fontFamily: "NeueRegrade",
                      ),
                    )
                  ])
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: new EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                LinkItem(
                    title: "Modifier mon profil",
                    onTap: () {
                      Navigator.pushNamed(context, '/modifier');
                    }),
                SizedBox(
                  height: 10,
                ),
                LinkItem(
                    title: "Mes annonces",
                    onTap: () {
                      Navigator.pushNamed(context, '/mes-annonces');
                    }),
                SizedBox(
                  height: 10,
                ),
                LinkItem(
                    title: "Mes objets",
                    onTap: () {
                      Navigator.pushNamed(context, '/mes-objets');
                    }),
                SizedBox(
                  height: 10,
                ),
                LinkItem(
                    title: "Mes avis",
                    onTap: () {
                      Navigator.pushNamed(context, '/mes-avis');
                    }),
                SizedBox(
                  height: 10,
                ),
                LinkItem(
                    title: "Me déconnecter",
                    isWarning: true,
                    onTap: () async {
                      await supabase.auth.signOut();
                      print('Utilisateur déconnecté');
                      Navigator.of(context, rootNavigator: true)
                          .pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => WelcomePage()),
                        (Route<dynamic> route) => false,
                      );
                    }),
                SizedBox(
                  height: 36,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
