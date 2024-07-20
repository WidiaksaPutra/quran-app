// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:app_quran/controller/mixin/mixin_shared_pref.dart';
import 'package:app_quran/model/model_detail_tafsir.dart';
import 'package:app_quran/service/api_konstanta.dart';
import 'package:app_quran/service/detail_tafsir/interfaces_detail_tafsir.dart';

class ApiDetailTafsir with SharedPref implements InterfacesDetailTafsir{
  
  @override
  dynamic detailDataTafsir = {};
  
  @override
  String urlDetailTafsir = "/tafsir";
  
  @override
  Future fetchDataDetailTafsir({required String nomor}) async {
    try{
      print("test data taff");
      await sharedPref();
      var requestUrl = Api.baseApi + "/tafsir/$nomor";
      final response = await Api.client.get(Uri.parse(requestUrl)).timeout(const Duration(seconds: 10));
      print("test code satus taf ${response.statusCode}");
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        ModelDetailTafsir detailTafsir = ModelDetailTafsir.fromJson(parsed);
        print("test data service tafsir ${detailTafsir.data}");
        return detailTafsir.data!;
      }
      else {
        throw Exception('Failed to load data');
      }
    }catch (e) {
      throw Exception('data error');
    }
  }
}