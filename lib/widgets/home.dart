import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/card_annonce.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/annonce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  // fais un exemple de liste avec quelques annonces
  final List<Annonce> lesAnnonces = [
    Annonce(
      titre: 'Annonce 1',
      imageLink: 'assets/perceuse.jpeg',
      isSaved: false,
      prix: 100,
      niveauUrgence: 1,
    ),
    Annonce(
      titre: 'Annonce 2',
      imageLink: 'assets/perceuse.jpeg',
      isSaved: true,
      prix: 200,
      niveauUrgence: 2,
    ),
    Annonce(
      titre: 'Annonce 3',
      imageLink: 'assets/perceuse.jpeg',
      isSaved: false,
      prix: 300,
      niveauUrgence: 3,
    ),
    Annonce(
      titre: 'Annonce 4',
      imageLink: 'assets/perceuse.jpeg',
      isSaved: true,
      prix: 400,
      niveauUrgence: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Accueil',
          style: TextStyle(
            color: AppColors.dark,
            fontSize: 24.0,
            fontFamily: "NeueRegrade",
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.light,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          canvasColor: AppColors.light,
          primaryColor: AppColors.accent,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: AppColors.darkSecondary),
              ),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex != 0
                    ? 'assets/icons/home.svg'
                    : 'assets/icons/home-filled.svg',
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex != 1
                    ? 'assets/icons/bookmark.svg'
                    : 'assets/icons/bookmark-filled.svg',
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SvgPicture.asset(
                    'assets/icons/handshake.svg',
                  ),
                ),
              ),
              label: 'Handshake',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex != 3
                    ? 'assets/icons/bell.svg'
                    : 'assets/icons/bell-filled.svg',
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex != 4
                    ? 'assets/icons/user-rounded.svg'
                    : 'assets/icons/user-rounded-filled.svg',
              ),
              label: 'Home',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0.0,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
              padding: new EdgeInsets.fromLTRB(15, 20, 15, 0),
              child: CustomTextField(
                  hint: "Rechercher une annonce...",
                  iconPath: "assets/icons/loupe.svg")),
          ListeAnnonce(titre: "Vous pouvez les aider !", annonces: lesAnnonces),
          ListeAnnonce(titre: "Annonces urgentes", annonces: lesAnnonces),
          ListeAnnonce(titre: "Annonces récentes", annonces: lesAnnonces),
        ],
      ),
    );
  }
}
