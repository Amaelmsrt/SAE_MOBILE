import 'package:allo/models/app_bar_title.dart';
import 'package:allo/widgets/my_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://prkgslozjxihdimuphji.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBya2dzbG96anhpaGRpbXVwaGppIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTA3NzU3NjksImV4cCI6MjAyNjM1MTc2OX0.iAPdkmMLSOTpVQOkGdtlBdjpz56KJ2vMQmIeTl2HWxY',
    authFlowType: AuthFlowType.pkce,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppBarTitle(),
      child: MyApp()
    )
  );
}

final supabase = Supabase.instance.client;