// ignore_for_file: non_constant_identifier_names

abstract class InterfaceInsertAyatSqlite{
  Future<void> InsertDataAyatSqlite({
    required String nomor ,
    required String namaLatin,
    required String teksArab,
    required String nomorAyat,
    required String teksLatin,
    required String teksIndonesia,
  });
  bool get StatusInsertSqlite;
}