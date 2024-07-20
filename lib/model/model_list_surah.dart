import 'dart:convert';

class ModelListSurah {
    final int? code;
    final String? message;
    final List<Datum>? data;

    ModelListSurah({
        this.code,
        this.message,
        this.data,
    });

    factory ModelListSurah.fromRawJson(String str) => ModelListSurah.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ModelListSurah.fromJson(Map<String, dynamic> json) => ModelListSurah(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
  final int? nomor;
  final String? nama;
  final String? namaLatin;
  final int? jumlahAyat;
  final String? tempatTurun;
  final String? arti;
  final String? deskripsi;
  final Map<String, String>? audioFull;

  Datum({
      this.nomor,
      this.nama,
      this.namaLatin,
      this.jumlahAyat,
      this.tempatTurun,
      this.arti,
      this.deskripsi,
      this.audioFull,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      nomor: json["nomor"],
      nama: json["nama"],
      namaLatin: json["namaLatin"],
      jumlahAyat: json["jumlahAyat"],
      tempatTurun: json["tempatTurun"],
      arti: json["arti"],
      deskripsi: json["deskripsi"],
      audioFull: Map.from(json["audioFull"]!).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
      "nomor": nomor,
      "nama": nama,
      "namaLatin": namaLatin,
      "jumlahAyat": jumlahAyat,
      "tempatTurun": tempatTurun,
      "arti": arti,
      "deskripsi": deskripsi,
      "audioFull": Map.from(audioFull!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}