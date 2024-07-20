import 'package:app_quran/service/detail_tafsir/interfaces_detail_tafsir.dart';
import 'package:app_quran/shared/theme_konstanta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final interfaceDetailDataDetailTafsirProvider = Provider<InterfacesDetailTafsir>((ref) {
  return getItInstance<InterfacesDetailTafsir>();
});

final fetchDataDetailTafsirRiverpod = StateNotifierProvider<FetchDataDetailTafsirRiverpod, bool>((ref) {
  final fetchDataDetailTafsirNotifier = FetchDataDetailTafsirRiverpod(ref.watch(interfaceDetailDataDetailTafsirProvider));
  return fetchDataDetailTafsirNotifier;
});

class FetchDataDetailTafsirRiverpod extends StateNotifier<bool>{
  //  implements InterfaceFetchDataDetailTafsirRiverpod
  late dynamic _detailTafsir = {};
  InterfacesDetailTafsir _dataDetailTafsir = getItInstance<InterfacesDetailTafsir>();
  FetchDataDetailTafsirRiverpod(this._dataDetailTafsir) : super(false);

  @override
  Future<void> fetchDataDetailSurah({required String nomor}) async {
    print("test data taf river");
    state = true;
    _detailTafsir = await _dataDetailTafsir.fetchDataDetailTafsir(nomor: nomor);
    state = false;
  }

  @override
  get detailTafsir => _detailTafsir;
}