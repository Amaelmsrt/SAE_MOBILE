import 'package:flutter/foundation.dart';

class AppBarTitle with ChangeNotifier {
  String _title = 'Accueil';

  String get title => _title;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }
}