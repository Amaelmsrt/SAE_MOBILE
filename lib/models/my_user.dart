import 'package:allo/models/utilisateur.dart';
import 'package:flutter/foundation.dart';

class MyUser extends ChangeNotifier{
  Utilisateur? _myUser = null;

  Utilisateur? get myUser => _myUser;

  void setMyUser(Utilisateur user) {
    _myUser = user;
    notifyListeners();
  }
}