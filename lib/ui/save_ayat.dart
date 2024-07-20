// ignore_for_file: must_be_immutable, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:app_quran/componen/componen_loading.dart';
import 'package:app_quran/controller/mixin/mixin_size_device.dart';
import 'package:app_quran/controller/riverpod/detail_surah/fetch_data_detail_surah_riverpod.dart';
import 'package:app_quran/controller/riverpod/save_ayat_sqlite/get_ayat/get_ayat_sqlite.dart';
import 'package:app_quran/controller/riverpod/save_ayat_sqlite/insert_ayat/insert_ayat_sqlite.dart';
import 'package:app_quran/controller/riverpod/util/loading_riverpod.dart';
import 'package:app_quran/routes/route_name.dart';
import 'package:app_quran/shared/theme_box.dart';
import 'package:app_quran/shared/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _dataAyat = StateProvider.autoDispose<dynamic>((ref) => null);

class SaveAyat extends ConsumerWidget with SizeDevice{
  SaveAyat({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeBox(context);
    getsizeDevice(context);
    if(ref.watch(_dataAyat) == null){
      Future.delayed(Duration.zero,() async{
        await ref.watch(getAyatSqliteRiverpod.notifier).GetDataAyatSqlite();
        ref.read(_dataAyat.notifier).state = ref.watch(getAyatSqliteRiverpod.notifier).dataAyatSqlite;
        ref.read(isLoadingFetchDataDetailSurahRiverpod.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).state;
        Future.delayed(const Duration(milliseconds: 1000), (){
          ref.read(isLoadingFetchDataDetailSurahRiverpod.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).state;
        });
      });
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: (ref.watch(_dataAyat) == null || ref.watch(isLoadingFetchDataDetailSurahRiverpod) == true)
        ? Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200))
        : Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ThemeBox.defaultWidthBox10,
                ),
                child: Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: ThemeBox.defaultHeightBox5,
                    ),
                    decoration: BoxDecoration(
                      color: kPurpleColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(ThemeBox.defaultRadius15),
                        bottomLeft: Radius.circular(ThemeBox.defaultRadius15),
                      ),
                    ),
                    child: const Center(child: Text("Lihat Surat", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ThemeBox.defaultWidthBox13,
                  vertical: ThemeBox.defaultHeightBox13,
                ),
                child: SizedBox(
                  height: sizeHeight - 240.0,
                  child: ListView.builder(
                    itemCount: ref.watch(_dataAyat).length,
                    itemBuilder: (context, index){
                      return Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ThemeBox.defaultWidthBox10,
                                  vertical: ThemeBox.defaultHeightBox10,
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: ThemeBox.defaultHeightBox10,
                                  horizontal: ThemeBox.defaultHeightBox20,
                                ),
                                decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(ThemeBox.defaultRadius15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: kGreyColor5,
                                      spreadRadius: 0.5,
                                      blurRadius: 3,
                                      offset: Offset(0, 3)
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${ref.watch(_dataAyat)[index]['nomor']}:${ref.watch(_dataAyat)[index]['nomorAyat']}"),
                                    Text(ref.watch(_dataAyat)[index]['teksArab'].toString()),
                                    Text(ref.watch(_dataAyat)[index]['teksLatin'].toString()),
                                    Text(ref.watch(_dataAyat)[index]['teksIndonesia'].toString()),
                                  ],
                                ),
                              ),
                              onTap: () {
                                // ref.watch(insertAyatSqliteRiverpod.notifier).InsertDataAyatSqlite(
                                //   id: '1', 
                                //   nomor: ref.watch(_dataAyat).nomor.toString(), 
                                //   namaLatin: ref.watch(_dataAyat).namaLatin.toString(),
                                //   teksArab: ref.watch(_dataAyat).ayat[index].teksArab.toString(),
                                //   nomorAyat: ref.watch(_dataAyat).ayat[index].nomorAyat.toString(), 
                                //   teksLatin: ref.watch(_dataAyat).ayat[index].teksLatin.toString(),
                                //   teksIndonesia: ref.watch(_dataAyat).ayat[index].teksIndonesia.toString(),
                                // );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}