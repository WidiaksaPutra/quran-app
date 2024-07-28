// ignore_for_file: override_on_non_overriding_member, prefer_final_fields, non_constant_identifier_names

import 'package:app_quran/controller/riverpod/ayat_sqlite/insert_ayat/interface_insert_ayat_sqlite_riverpod.dart';
import 'package:app_quran/shared/theme_global_variabel.dart';
import 'package:app_quran/sqlite/interfaces_ayat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final interfaceInsertAyatSqliteProvider = Provider<InterfacesAyat>((ref) {
  return getItInstance<InterfacesAyat>();
});

final insertAyatSqliteRiverpod = StateNotifierProvider<InsertAyatSqlite, bool>((ref) {
  final insertAyatSqliteNotifier = InsertAyatSqlite(ref.watch(interfaceInsertAyatSqliteProvider));
  return insertAyatSqliteNotifier;
});

class InsertAyatSqlite extends StateNotifier<bool> implements InterfaceInsertAyatSqlite{
  late int _statusInsertSqlite = 0;
  InterfacesAyat _insertAyat = getItInstance<InterfacesAyat>();
  InsertAyatSqlite(this._insertAyat) : super(false);

  @override
  Future<void> InsertDataAyatSqlite({
    required String nomor, 
    required String namaLatin, 
    required String teksArab, 
    required String nomorAyat, 
    required String teksLatin, 
    required String teksIndonesia,
  }) async {
     state = true;
    _statusInsertSqlite = await _insertAyat.insertAyat(
      nomor: nomor, 
      namaLatin: namaLatin, 
      teksArab: teksArab, 
      nomorAyat: nomorAyat, 
      teksLatin: teksLatin, 
      teksIndonesia: teksIndonesia,
    );
    state = false;
  }

  @override
  bool get StatusInsertSqlite{
    if(_statusInsertSqlite == 0){
      return false;
    }else{
      return true;
    } 
  }
}