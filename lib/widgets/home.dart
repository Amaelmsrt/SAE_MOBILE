import 'package:allo/components/ListeAnnonce.dart';
import 'package:allo/components/card_annonce.dart';
import 'package:allo/components/custom_text_field.dart';
import 'package:allo/constants/app_colors.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/app_bar_title.dart';
import 'package:allo/widgets/accueil.dart';
import 'package:allo/widgets/annonces_enregistres.dart';
import 'package:allo/widgets/page_notifications.dart';
import 'package:allo/widgets/page_profil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../models/DB/annonce_db.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Annonce> lesAnnonces = [];

  @override
  void initState() {
    super.initState();
    fetchAnnonces();
  }

  Future<void> fetchAnnonces() async {
    final annonces = await AnnonceDB.fetchAllAnnonces();
    setState(() {
      lesAnnonces = annonces;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Provider.of<AppBarTitle>(context).title,
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
      body: _selectedIndex == 0 ? Accueil() : _selectedIndex == 1 ? AnnoncesEnregistrees() : _selectedIndex == 3 ? PageNotifications() : _selectedIndex == 4 ? PageProfil() : null,
    );
  }
}
