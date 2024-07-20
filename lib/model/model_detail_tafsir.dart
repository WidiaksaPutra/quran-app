import 'dart:convert';

class ModelDetailTafsir {
    final int? code;
    final String? message;
    final Data? data;

    ModelDetailTafsir({
        this.code,
        this.message,
        this.data,
    });

    factory ModelDetailTafsir.fromRawJson(String str) => ModelDetailTafsir.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ModelDetailTafsir.fromJson(Map<String, dynamic> json) => ModelDetailTafsir(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    final int? nomor;
    final String? nama;
    final String? namaLatin;
    final int? jumlahAyat;
    final String? tempatTurun;
    final String? arti;
    final String? deskripsi;
    final Map<String, String>? audioFull;
    final List<Tafsir>? tafsir;

    Data({
        this.nomor,
        this.nama,
        this.namaLatin,
        this.jumlahAyat,
        this.tempatTurun,
        this.arti,
        this.deskripsi,
        this.audioFull,
        this.tafsir,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        nomor: json["nomor"],
        nama: json["nama"],
        namaLatin: json["namaLatin"],
        jumlahAyat: json["jumlahAyat"],
        tempatTurun: json["tempatTurun"],
        arti: json["arti"],
        deskripsi: json["deskripsi"],
        audioFull: Map.from(json["audioFull"]!).map((k, v) => MapEntry<String, String>(k, v)),
        tafsir: json["tafsir"] == null ? [] : List<Tafsir>.from(json["tafsir"]!.map((x) => Tafsir.fromJson(x))),
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
        "tafsir": tafsir == null ? [] : List<dynamic>.from(tafsir!.map((x) => x.toJson())),
    };
}

class Tafsir {
    final int? ayat;
    final String? teks;

    Tafsir({
        this.ayat,
        this.teks,
    });

    factory Tafsir.fromRawJson(String str) => Tafsir.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Tafsir.fromJson(Map<String, dynamic> json) => Tafsir(
        ayat: json["ayat"],
        teks: json["teks"],
    );

    Map<String, dynamic> toJson() => {
        "ayat": ayat,
        "teks": teks,
    };
}