import 'package:app_quran/main/main_screen.dart';
import 'package:app_quran/service/daftar_surah/injection_daftar_surah.dart';
import 'package:app_quran/service/detail_surah/injection_detail_surah.dart';
import 'package:app_quran/service/detail_tafsir/injection_detail_tafsir.dart';
import 'package:app_quran/sqlite/injection_sqlite_ayat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{
  setupDInjectionDaftarSurah();
  setupDInjectionDetailSurah();
  setupDInjectionSqlLiteAyat();
  setupDInjectionDetailTafsir();
  initializeDateFormatting('ar', null).then((_){
    initializeDateFormatting('en', null).then((_){
      runApp(const ProviderScope(child: MyApp()));
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
