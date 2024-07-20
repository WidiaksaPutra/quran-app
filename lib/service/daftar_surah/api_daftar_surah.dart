// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations
import 'dart:convert';

import 'package:app_quran/controller/mixin/mixin_shared_pref.dart';
import 'package:app_quran/model/model_list_surah.dart';
import 'package:app_quran/service/api_konstanta.dart';
import 'package:app_quran/service/daftar_surah/interfaces_daftar_surah.dart';

class ApiDaftarSurah with SharedPref implements InterfacesDaftarSurah{
  @override
  String urlSurat = "/surat";

  @override
  List listDataSurat = [];

  @override
  Future<List> fetchDataDaftarSurah() async{
    try{
      await sharedPref();
      var requestUrl = Api.baseApi + "$urlSurat";
      final response = await Api.client.get(Uri.parse(requestUrl)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        ModelListSurah listSurah = ModelListSurah.fromJson(parsed);
        listDataSurat.addAll(listSurah.data!);
        return listDataSurat;
      }
      else {
        throw Exception('Failed to load data');
      }
    }catch (e) {
      throw Exception('data error');
    }
  }
}