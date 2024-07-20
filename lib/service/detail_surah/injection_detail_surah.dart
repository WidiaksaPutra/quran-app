import 'package:app_quran/service/detail_surah/api_detail_surah.dart';
import 'package:app_quran/service/detail_surah/interfaces_detail_surah.dart';
import 'package:app_quran/shared/theme_konstanta.dart';

void setupDInjectionDetailSurah(){
  if(!getItInstance.isRegistered<InterfacesDetailSurah>()){
    getItInstance.registerFactory<InterfacesDetailSurah>(() => ApiDetailSurah());
  }
}