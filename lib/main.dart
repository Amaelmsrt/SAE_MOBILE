import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/index_page_notifications.dart';
import 'package:allo/widgets/my_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => AppBarTitle()),
          ChangeNotifierProvider(create: (context) => IndexPageNotifications()),
        // Ajoutez d'autres providers ici si nécessaire
      ],
      child: MyApp()
    )
  );
}