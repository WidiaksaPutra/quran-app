import 'package:app_quran/service/daftar_surah/api_daftar_surah.dart';
import 'package:app_quran/service/daftar_surah/interfaces_daftar_surah.dart';
import 'package:app_quran/shared/theme_global_variabel.dart';

void setupDInjectionDaftarSurah(){
  if(!getItInstance.isRegistered<InterfacesDaftarSurah>()){
    getItInstance.registerFactory<InterfacesDaftarSurah>(() => ApiDaftarSurah());
  }
}