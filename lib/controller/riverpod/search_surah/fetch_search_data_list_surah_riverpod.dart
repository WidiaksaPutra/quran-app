// ignore_for_file: avoid_init_to_null, prefer_final_fields
import 'package:app_quran/controller/riverpod/search_surah/interface_search_data_pekerja_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchSearchDataListSurahRiverpod = StateNotifierProvider<FetchSearchDataListSurahRiverpord, bool>((ref) {
  return FetchSearchDataListSurahRiverpord();
});

class FetchSearchDataListSurahRiverpord extends StateNotifier<bool> implements InterfaceSearchDataPekerjaRiverpod{
  late List _listSurah = [];
  FetchSearchDataListSurahRiverpord() : super(false);

  @override
  Future<void> searchDataListSurah({
    required List listDataSurah,
    required String searchSurah,
  }) async{
    state = true;
    _listSurah.clear();
    if(listDataSurah.isNotEmpty){
      for(var data in listDataSurah){
        if(data.namaLatin.toLowerCase().contains(searchSurah.toLowerCase())){
          _listSurah.add(data);
        }
      }
    }
    state = false;
  }

  @override
  List get listSurah => _listSurah;
}