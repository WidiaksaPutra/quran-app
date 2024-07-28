import 'package:app_quran/shared/theme_global_variabel.dart';
import 'package:app_quran/sqlite/helper_ayat.dart';
import 'package:app_quran/sqlite/interfaces_ayat.dart';

void setupDInjectionSqlLiteAyat(){
  if(!getItInstance.isRegistered<InterfacesAyat>()){
    getItInstance.registerFactory<InterfacesAyat>(() => HelperAyat());
  }
}