import 'package:allo/components/vue_avis.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/avis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MesAvis extends StatefulWidget {
  @override
  _MesAvisState createState() => _MesAvisState();
}

class _MesAvisState extends State<MesAvis> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppBarTitle>(context, listen: false).setTitle('Mes avis');
    });
  }

  List<Avis> mesAvis = [
    new Avis(
        pseudo: "Julien Arsouze",
        commentaire:
            "Salut j’ai beaucoup aimé sa perceuse franchement un pur banger j’ai kiffé on refait ça quand tu veux mon frérot love sur toi jtm.",
        date: "il y a 5 minutes",
        nbEtoiles: 4)
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: new EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          children: [
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
                ]),
              SizedBox(height: 30), // Add this
            Expanded(
              // Add this
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return VueAvis(
                          imagePath: mesAvis[index].imagePath,
                          pseudo: mesAvis[index].pseudo,
                          commentaire: mesAvis[index].commentaire,
                          date: mesAvis[index].date,
                          nbEtoiles: mesAvis[index].nbEtoiles,
                        );
                      },
                      childCount: mesAvis.length,
                    ),
                  ),
                ],
              ),
            ) // Add this
          ],
        ));
  }
}
