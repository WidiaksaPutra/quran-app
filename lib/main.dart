import 'package:app_quran/main/dependency_injection.dart';
import 'package:app_quran/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  dependencyInjectionInit();
  initializeDateFormatting('ar', null).then((_){
    runApp(const ProviderScope(child: MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}
