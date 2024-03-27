import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/components/link_item.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/widgets/home_profil.dart';
import 'package:allo/widgets/mes_annonces.dart';
import 'package:allo/widgets/mes_avis.dart';
import 'package:allo/widgets/mes_objets.dart';
import 'package:allo/widgets/modifier_profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PageProfil extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<PageProfil> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool isPop) {
        final NavigatorState navigator = Navigator.of(context);
        if (navigator.canPop()) {
          navigator.pop();
        }
      },
      child: Navigator(
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return Stack(
                children: <Widget>[
                  Padding(padding: new EdgeInsets.only(top:100),
                  child: 
                    settings.name == "/modifier" ?
                      ModifierProfil()
                    : settings.name == "/mes-avis" ?
                      MesAvis()
                    :
                      settings.name == "/mes-annonces" ?
                      MesAnnonces()
                    :
                      settings.name == "/mes-objets" ?
                      MesObjets()
                    :
                      HomeProfil(),
                  ),
                    Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 110,
                width: MediaQuery.of(context).size.width,
                color: AppColors.light,
                alignment: Alignment.center,
              ),
            ),
            Positioned(
              top: 45,
              left: 0,
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Center(child: Text(Provider.of<AppBarTitle>(context).title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: "NeueRegrade",
                    ))),
              ),
            ),
            if (Navigator.canPop(context))
            Positioned(
              top: 45,
              left: 25,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 45, // same height as a FAB
                  width: 45, // same width as a FAB
                  decoration: BoxDecoration(
                    color: AppColors.primary, // same color as your FAB
                    borderRadius: BorderRadius.circular(
                        8000), // change this to your desired border radius
                  ),
                  child: Center(
                    child:
                        SvgPicture.asset("assets/icons/arrow-back.svg"), // your icon
                  ),
                ),
              ),
            ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
