import 'package:allo/models/app_bar_title.dart';
import 'package:allo/widgets/my_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppBarTitle(),
      child: MyApp()
    )
  );
}