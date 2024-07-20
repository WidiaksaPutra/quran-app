// ignore_for_file: prefer_final_fields, non_constant_identifier_names

import 'package:app_quran/controller/riverpod/save_ayat_sqlite/get_ayat/interface_get_ayat_sqlite.dart';
import 'package:app_quran/shared/theme_konstanta.dart';
import 'package:app_quran/sqlite/interfaces_ayat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final interfaceGetAyatSqliteProvider = Provider<InterfacesAyat>((ref) {
  return getItInstance<InterfacesAyat>();
});

final getAyatSqliteRiverpod = StateNotifierProvider<GetAyatSqlite, bool>((ref) {
  final getAyatSqliteNotifier = GetAyatSqlite(ref.watch(interfaceGetAyatSqliteProvider));
  return getAyatSqliteNotifier;
});

class GetAyatSqlite extends StateNotifier<bool> implements InterfaceGetAyatSqlite{
  late List<Map<String, dynamic>> _listAyatSqlite = [];
  InterfacesAyat _dataAyatSqlite = getItInstance<InterfacesAyat>();
  GetAyatSqlite(this._dataAyatSqlite) : super(false);

  @override
  Future<void> GetDataAyatSqlite() async{
    print("test sqlite get");
    state = true;
    _listAyatSqlite = await _dataAyatSqlite.getAyat();
    state = false;
  }
  
  @override
  List<Map<String, dynamic>> get dataAyatSqlite => _listAyatSqlite;
}