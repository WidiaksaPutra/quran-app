abstract class InterfacesAyat{
  Future<List<Map<String, dynamic>>> getAyat();
  Future<int> deleteAyat({required String id});
  Future<int> insertAyat({
    required String nomor,
    required String namaLatin ,
    required String teksArab,
    required String nomorAyat,
    required String teksLatin,
    required String teksIndonesia
  });
}