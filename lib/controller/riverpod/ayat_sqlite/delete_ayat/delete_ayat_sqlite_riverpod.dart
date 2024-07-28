// ignore_for_file: non_constant_identifier_names, prefer_final_fields

import 'package:app_quran/controller/riverpod/ayat_sqlite/delete_ayat/interface_delete_ayat_sqlite_riverpod.dart';
import 'package:app_quran/shared/theme_global_variabel.dart';
import 'package:app_quran/sqlite/interfaces_ayat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final interfaceDeleteAyatSqliteProvider = Provider<InterfacesAyat>((ref) {
  return getItInstance<InterfacesAyat>();
});

final deleteAyatSqliteRiverpod = StateNotifierProvider<DeleteAyatSqlite, bool>((ref) {
  final deleteAyatSqliteNotifier = DeleteAyatSqlite(ref.watch(interfaceDeleteAyatSqliteProvider));
  return deleteAyatSqliteNotifier;
});

class DeleteAyatSqlite extends StateNotifier<bool> implements InterfaceDeleteAyatSqlite{
  late int _statusDeleteSqlite = 0;
  InterfacesAyat _deleteAyat = getItInstance<InterfacesAyat>();
  DeleteAyatSqlite(this._deleteAyat) : super(false);

  @override
  Future<void> DeleteDataAyatSqlite({required String id}) async {
    state = true;
    _statusDeleteSqlite = await _deleteAyat.deleteAyat(id: id);
    state = false;
  }
  
  @override
  bool get StatusDeleteSqlite{
    if(_statusDeleteSqlite == 0){
      return false;
    }else{
      return true;
    } 
  }
}