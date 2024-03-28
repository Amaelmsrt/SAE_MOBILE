import 'package:allo/components/link_item.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/app_bar_title.dart';
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
      Provider.of<AppBarTitle>(context, listen: false)
          .setTitle('Mon profil');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  color: AppColors.lightBlue,
                  width: 130, // you can adjust width and height to your liking
                  height: 130, // you can adjust width and height to your liking
                  child: Text(
                    'J',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      fontFamily: "NeueRegrade",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Julien Arsouze",
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
                    SvgPicture.asset("assets/icons/star.svg", height: 16),
                    SvgPicture.asset("assets/icons/star.svg", height: 16),
                    SvgPicture.asset("assets/icons/star.svg", height: 16),
                    SvgPicture.asset("assets/icons/star.svg", height: 16),
                    SvgPicture.asset("assets/icons/star.svg", height: 16),
                    SizedBox(width: 8),
                    Text(
                      '158 avis',
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
            height: 36,
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
                  height: 12,
                ),
                LinkItem(title: "Mes annonces", onTap: () {
                   Navigator.pushNamed(context, '/mes-annonces');
                }),
                SizedBox(
                  height: 12,
                ),
                LinkItem(title: "Mes objets", onTap: () {
                   Navigator.pushNamed(context, '/mes-objets');
                }),
                SizedBox(
                  height: 12,
                ),
                LinkItem(title: "Mes avis", onTap: () {
                   Navigator.pushNamed(context, '/mes-avis');
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}