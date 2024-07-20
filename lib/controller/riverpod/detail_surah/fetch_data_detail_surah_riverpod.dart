// ignore_for_file: unused_field, prefer_final_fields

import 'package:app_quran/controller/riverpod/detail_surah/interface_fetch_data_detail_surah_riverpod.dart';
import 'package:app_quran/service/detail_surah/interfaces_detail_surah.dart';
import 'package:app_quran/shared/theme_konstanta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final interfaceDetailDataDetailSurahProvider = Provider<InterfacesDetailSurah>((ref) {
  return getItInstance<InterfacesDetailSurah>();
});

final fetchDataDetailSurahRiverpod = StateNotifierProvider<FetchDataDetailSurahRiverpod, bool>((ref) {
  final fetchDataDetailSurahNotifier = FetchDataDetailSurahRiverpod(ref.watch(interfaceDetailDataDetailSurahProvider));
  return fetchDataDetailSurahNotifier;
});

class FetchDataDetailSurahRiverpod extends StateNotifier<bool> implements InterfaceFetchDataDetailSurahRiverpod{
  late dynamic _detailSurah = {};
  InterfacesDetailSurah _dataDetailSurah = getItInstance<InterfacesDetailSurah>();
  FetchDataDetailSurahRiverpod(this._dataDetailSurah) : super(false);

  @override
  Future<void> fetchDataDetailSurah({required String nomor}) async {
    state = true;
    _detailSurah = await _dataDetailSurah.fetchDataDetailSurah(nomor: nomor);
    state = false;
  }

  @override
  get detailSurah => _detailSurah;
}