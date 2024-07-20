import 'package:sqflite/sqflite.dart' as sql;

class SqlAyat{
  static Future<void> createTableAyat(sql.Database database) async{
    await database.execute("""
      CREATE TABLE ayat(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nomor STRING,
        namaLatin STRING,
        teksArab TEXT,
        nomorAyat STRING,
        teksLatin TEXT,
        teksIndonesia TEXT
      )
    """);
  }

  static Future<sql.Database> db() async{
    return sql.openDatabase('ayat.db', version: 1, onCreate: (sql.Database database, int version) async {
      await createTableAyat(database);
    });
  }
}