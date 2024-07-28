import 'package:app_quran/service/daftar_surah/injection_daftar_surah.dart';
import 'package:app_quran/service/detail_surah/injection_detail_surah.dart';
import 'package:app_quran/service/detail_tafsir/injection_detail_tafsir.dart';
import 'package:app_quran/sqlite/injection_sqlite_ayat.dart';

void dependencyInjectionInit(){
  setupDInjectionDaftarSurah();
  setupDInjectionDetailSurah();
  setupDInjectionSqlLiteAyat();
  setupDInjectionDetailTafsir();
}