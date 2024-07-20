// ignore_for_file: avoid_init_to_null, prefer_final_fields
import 'package:app_quran/controller/riverpod/list_surah/interface_fetch_data_pekerja_riverpod.dart';
import 'package:app_quran/service/daftar_surah/interfaces_daftar_surah.dart';
import 'package:app_quran/shared/theme_konstanta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final interfaceFetchDataListSurahProvider = Provider<InterfacesDaftarSurah>((ref) {
  return getItInstance<InterfacesDaftarSurah>();
});

final fetchDataListSurahRiverpod = StateNotifierProvider<FetchDataListSurahRiverpord, bool>((ref) {
  final fetchDataListSurahNotifier = FetchDataListSurahRiverpord(ref.watch(interfaceFetchDataListSurahProvider));
  return fetchDataListSurahNotifier;
});

class FetchDataListSurahRiverpord extends StateNotifier<bool> implements InterfaceFetchDataListSurahRiverpord{
  late List? _listSurah = [];
  InterfacesDaftarSurah _dataDaftarSurah = getItInstance<InterfacesDaftarSurah>();
  FetchDataListSurahRiverpord(this._dataDaftarSurah) : super(false);

  @override
  Future<void> FetchDataListSurah() async {
    state = true;
    _listSurah = await _dataDaftarSurah.fetchDataDaftarSurah();
    state = false;
  }
  
  @override
  List? get ListSurah => _listSurah;
}
