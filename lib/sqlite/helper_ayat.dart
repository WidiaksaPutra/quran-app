import 'package:app_quran/sqlite/interfaces_ayat.dart';
import 'package:app_quran/sqlite/sql_ayat.dart';

class HelperAyat implements InterfacesAyat{

  @override
  Future<int> deleteAyat({required String id}) async{
    final db = await SqlAyat.db();
    return await db.delete('ayat', where:"id=$id");
  }
  
  @override
  Future<List<Map<String, dynamic>>> getAyat() async{
    final db = await SqlAyat.db();
    dynamic data = await db.query('ayat');
    return data;
  }
  
  @override
  Future<int> insertAyat({
    required String nomor, 
    required String namaLatin, 
    required String teksArab, 
    required String nomorAyat, 
    required String teksLatin, 
    required String teksIndonesia,
  }) async {
    final db = await SqlAyat.db();
    final dataInsert = {
      'nomor': nomor,
      'namaLatin': namaLatin,
      'teksArab': teksArab, 
      'nomorAyat': nomorAyat, 
      'teksLatin': teksLatin,
      'teksIndonesia': teksIndonesia
    };
    return await db.insert('ayat', dataInsert);
  }
}