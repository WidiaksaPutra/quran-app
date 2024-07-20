// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_string_interpolations
import 'dart:convert';

import 'package:app_quran/controller/mixin/mixin_shared_pref.dart';
import 'package:app_quran/model/model_detail_surah.dart';
import 'package:app_quran/service/api_konstanta.dart';
import 'package:app_quran/service/detail_surah/interfaces_detail_surah.dart';

class ApiDetailSurah with SharedPref implements InterfacesDetailSurah{

  @override
  dynamic detailDataSurat = {};
  
  @override
  String urlDetailSurat = "/surat";
  
  @override
  Future<dynamic> fetchDataDetailSurah({required String nomor}) async{
    try{
      await sharedPref();
      var requestUrl = Api.baseApi + "$urlDetailSurat/$nomor";
      final response = await Api.client.get(Uri.parse(requestUrl)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        ModelDetailSurah detailSurah = ModelDetailSurah.fromJson(parsed);
        return detailSurah.data!;
      }
      else {
        throw Exception('Failed to load data');
      }
    }catch (e) {
      throw Exception('data error');
    }
  }
}