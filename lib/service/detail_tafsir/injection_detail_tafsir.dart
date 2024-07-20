import 'package:app_quran/service/detail_tafsir/api_detail_tafsir.dart';
import 'package:app_quran/service/detail_tafsir/interfaces_detail_tafsir.dart';
import 'package:app_quran/shared/theme_konstanta.dart';

void setupDInjectionDetailTafsir(){
  if(!getItInstance.isRegistered<InterfacesDetailTafsir>()){
    getItInstance.registerFactory<InterfacesDetailTafsir>(() => ApiDetailTafsir());
  }
}