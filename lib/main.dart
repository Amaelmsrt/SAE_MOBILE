import 'package:allo/models/app_bar_title.dart';
import 'package:allo/models/index_page_notifications.dart';
import 'package:allo/models/my_user.dart';
import 'package:allo/services/sqflite_service.dart';
import 'package:allo/widgets/my_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteService().initializeDB();
  await Supabase.initialize(
    url: 'https://prkgslozjxihdimuphji.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBya2dzbG96anhpaGRpbXVwaGppIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA3NzU3NjksImV4cCI6MjAyNjM1MTc2OX0.iAPdkmMLSOTpVQOkGdtlBdjpz56KJ2vMQmIeTl2HWxY',
    authFlowType: AuthFlowType.pkce,
  );
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => AppBarTitle()),
          ChangeNotifierProvider(create: (context) => IndexPageNotifications()),
          ChangeNotifierProvider(create: (context) => MyUser()),
        // Ajoutez d'autres providers ici si nécessaire
      ],
      child: MyApp()
    )
  );
}

final supabase = Supabase.instance.client;
