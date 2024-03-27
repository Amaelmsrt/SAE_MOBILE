import 'package:allo/components/custom_text_field.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ModifierProfil extends StatefulWidget {
  @override
  _ModifierProfilState createState() => _ModifierProfilState();
}

class _ModifierProfilState extends State<ModifierProfil> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<AppBarTitle>(context, listen: false)
          .setTitle('Modifier le profil');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: SingleChildScrollView( // Add this
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Stack(
                children: [
                  ClipOval(
                    child: Container(
                      alignment: Alignment.center,
                      color: AppColors.lightBlue,
                      width: 130,
                      height: 130,
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                      child: GestureDetector(
                    onTap: () {
                      
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/icons/img-upload.svg",
                          width: 24,
                          height: 24,
                          color: AppColors.light,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(height: 30,),
             CustomTextField(label: "Nom d'utilisateur", hint: "Nom d'utilisateur...", iconPath: "assets/icons/user.svg"),
                            CustomTextField(label: "E-mail", hint: "E-mail...", iconPath: "assets/icons/email.svg"),
                            CustomTextField(label: "Mot de passe", hint: "Mot de passe...", iconPath: "assets/icons/key.svg"),
                            ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 17, horizontal: 60),
                        elevation: 0,
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Text(
                        "Enregistrer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "NeueRegrade",
                          color: AppColors.dark,
                        ),
                      ),
                    ),
                  SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}