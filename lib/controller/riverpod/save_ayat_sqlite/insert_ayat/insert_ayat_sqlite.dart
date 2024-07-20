import 'package:app_quran/controller/riverpod/save_ayat_sqlite/insert_ayat/interface_insert_ayat_sqlite.dart';
import 'package:app_quran/shared/theme_konstanta.dart';
import 'package:app_quran/sqlite/interfaces_ayat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final interfaceInsertAyatSqliteProvider = Provider<InterfacesAyat>((ref) {
  return getItInstance<InterfacesAyat>();
});

final insertAyatSqliteRiverpod = StateNotifierProvider<InsertAyatSqlite, bool>((ref) {
  final insertAyatSqliteNotifier = InsertAyatSqlite(ref.watch(interfaceInsertAyatSqliteProvider));
  return insertAyatSqliteNotifier;
});

class InsertAyatSqlite extends StateNotifier<bool>{
  late int _statusInsertSqlite = 0;
  InterfacesAyat _insertAyat = getItInstance<InterfacesAyat>();
  InsertAyatSqlite(this._insertAyat) : super(false);

  @override
  Future<void> InsertDataAyatSqlite({
    required String id, 
    required String nomor, 
    required String namaLatin, 
    required String teksArab, 
    required String nomorAyat, 
    required String teksLatin, 
    required String teksIndonesia,
  }) async {
     state = true;
     print("test sqlite insert");
    _statusInsertSqlite = await _insertAyat.insertAyat(
      id: id, 
      nomor: nomor, 
      namaLatin: namaLatin, 
      teksArab: teksArab, 
      nomorAyat: nomorAyat, 
      teksLatin: teksLatin, 
      teksIndonesia: teksIndonesia,
    );
    print("test status insert $_statusInsertSqlite");
    state = false;
  }

  @override
  bool get statusInsertSqlite{
    if(_statusInsertSqlite == 0){
      return false;
    }else{
      return true;
    } 
  }
}