import 'package:allo/components/vue_avis.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/DB/avis_bd.dart';
import 'package:allo/models/Utilisateur.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/avis.dart';
import 'package:allo/models/my_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
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

  late Future<List<Avis>> mesAvis = AvisBD.getMesAvis();

  @override
  Widget build(BuildContext context) {
    Utilisateur? myUser = Provider.of<MyUser>(context).myUser;

    return Padding(
        padding: new EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset("assets/icons/star.svg",
                      height: 16,
                      color: myUser!.note >= 1
                          ? AppColors.yellow
                          : AppColors.primary),
                  SvgPicture.asset("assets/icons/star.svg",
                      height: 16,
                      color: myUser.note >= 2
                          ? AppColors.yellow
                          : AppColors.primary),
                  SvgPicture.asset("assets/icons/star.svg",
                      height: 16,
                      color: myUser.note >= 3
                          ? AppColors.yellow
                          : AppColors.primary),
                  SvgPicture.asset("assets/icons/star.svg",
                      height: 16,
                      color: myUser.note >= 4
                          ? AppColors.yellow
                          : AppColors.primary),
                  SvgPicture.asset("assets/icons/star.svg",
                      height: 16,
                      color: myUser.note >= 5
                          ? AppColors.yellow
                          : AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    '${myUser.nbAvis} avis',
                    style: TextStyle(
                      color: AppColors.dark,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      fontFamily: "NeueRegrade",
                    ),
                  )
                ]),
            SizedBox(height: 30), // Add this
            // Add this
            FutureBuilder<List<Avis>>(
              future: mesAvis,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Avis>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // or some other placeholder
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  print("data");
                  print(snapshot.data);
                  return Expanded(
                    child: ListView.separated(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
                        final formattedDate =
                            dateFormat.format(snapshot.data![index].dateAvis);

                        return VueAvis(
                          image: snapshot.data![index].utilisateur
                              .photoDeProfilUtilisateur,
                          pseudo:
                              snapshot.data![index].utilisateur.nomUtilisateur,
                          commentaire: snapshot.data![index].messageAvis,
                          date: formattedDate,
                          nbEtoiles: snapshot.data![index].noteAvis,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            height: 32); // Adjust the height as needed
                      },
                    ),
                  );
                }
              },
            )
          ],
        ));
  }
}
