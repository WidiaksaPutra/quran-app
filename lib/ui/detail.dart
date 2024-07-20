// ignore_for_file: must_be_immutable, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, await_only_futures

import 'package:app_quran/componen/componen_loading.dart';
import 'package:app_quran/controller/mixin/mixin_size_device.dart';
import 'package:app_quran/controller/riverpod/detail_surah/fetch_data_detail_surah_riverpod.dart';
import 'package:app_quran/controller/riverpod/detail_tafsir/fetch_data_detail_tafsir_riverpod.dart';
import 'package:app_quran/controller/riverpod/save_ayat_sqlite/insert_ayat/insert_ayat_sqlite.dart';
import 'package:app_quran/controller/riverpod/util/loading_riverpod.dart';
import 'package:app_quran/routes/route_name.dart';
import 'package:app_quran/shared/theme_box.dart';
import 'package:app_quran/shared/theme_color.dart';
import 'package:app_quran/ui/menu_home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _statusDetailSurah = StateProvider.autoDispose<bool>((ref) => true);
final _dataDetailAyat = StateProvider.autoDispose<dynamic>((ref) => null);
final _dataDetailTafsir = StateProvider.autoDispose<dynamic>((ref) => null);
class Detail extends ConsumerWidget with SizeDevice{
  Detail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeBox(context);
    getsizeDevice(context);
    final String nomor = ref.watch(dataNomorSurah).toString(); 
    if(ref.watch(_dataDetailAyat) == null){
      if(ref.watch(_statusDetailSurah) == true){
        Future.delayed(Duration.zero,() async{
          await ref.watch(fetchDataDetailSurahRiverpod.notifier).fetchDataDetailSurah(nomor: nomor);
          ref.read(_dataDetailAyat.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).detailSurah;
          ref.read(isLoadingFetchDataDetailSurahRiverpod.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).state;
          Future.delayed(const Duration(milliseconds: 1000), (){
            ref.read(isLoadingFetchDataDetailSurahRiverpod.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).state;
          });
        });
      }
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: (ref.watch(_dataDetailAyat) == null || ref.watch(isLoadingFetchDataDetailSurahRiverpod) == true)
        ? Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200))
        : Column(
            children: [
              GestureDetector(
                onTap: () => context.go(RouteName.menuHome),
                child: Expanded(
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
                      color: kPurpleColor,
                      borderRadius: BorderRadius.circular(ThemeBox.defaultRadius15)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(ref.watch(_dataDetailAyat).namaLatin, style: TextStyle(color: Colors.white),),
                        Text("${ref.watch(_dataDetailAyat).tempatTurun} . ${ref.watch(_dataDetailAyat).jumlahAyat} Ayat . ${ref.watch(_dataDetailAyat).arti}", style: TextStyle(color: Colors.white),),
                        const Divider(),
                        Text("text 3", style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ),
              (ref.watch(_statusDetailSurah) == true)
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ThemeBox.defaultWidthBox10,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
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
                                child: const Center(child: Text("Lihat Tafsir", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)),
                              ),
                              onTap: (){
                                Future.delayed(Duration.zero,() async{
                                  await ref.watch(fetchDataDetailTafsirRiverpod.notifier).fetchDataDetailSurah(nomor: nomor);
                                  ref.read(_dataDetailTafsir.notifier).state = ref.watch(fetchDataDetailTafsirRiverpod.notifier).detailTafsir;
                                  ref.read(isLoadingFetchDataDetailTafsirRiverpod.notifier).state = ref.watch(fetchDataDetailTafsirRiverpod.notifier).state;
                                  Future.delayed(const Duration(milliseconds: 1000), (){
                                    ref.read(isLoadingFetchDataDetailTafsirRiverpod.notifier).state = ref.watch(fetchDataDetailTafsirRiverpod.notifier).state;
                                  });
                                });
                                ref.read(_statusDetailSurah.notifier).state = false;
                              },
                            ),
                          ),
                          SizedBox(width: ThemeBox.defaultWidthBox5),
                          Expanded(
                            child: GestureDetector(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: ThemeBox.defaultHeightBox5,
                                ),
                                decoration: BoxDecoration(
                                  color: kPurpleColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(ThemeBox.defaultRadius15),
                                    bottomRight: Radius.circular(ThemeBox.defaultRadius15),
                                  ),
                                ),
                                child: const Center(child: Text("Play Audio", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)),
                              ),
                              onTap: (){
                                
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ThemeBox.defaultWidthBox13,
                        vertical: ThemeBox.defaultHeightBox13,
                      ),
                      child: SizedBox(
                        height: sizeHeight - 240.0,
                        child: (ref.watch(_dataDetailAyat).ayat.length == 0)
                        ? Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200))
                        : ListView.builder(
                          itemCount: ref.watch(_dataDetailAyat).ayat.length,
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
                                          Text("${ref.watch(_dataDetailAyat).nomor}:${ref.watch(_dataDetailAyat).ayat[index].nomorAyat}"),
                                          Text(ref.watch(_dataDetailAyat).ayat[index].teksArab),
                                          Text(ref.watch(_dataDetailAyat).ayat[index].teksLatin),
                                          Text(ref.watch(_dataDetailAyat).ayat[index].teksIndonesia),
                                        ],
                                      ),
                                    ),
                                    onTap: () async{
                                      await ref.watch(insertAyatSqliteRiverpod.notifier).InsertDataAyatSqlite(
                                        id: '1', 
                                        nomor: ref.watch(_dataDetailAyat).nomor.toString(), 
                                        namaLatin: ref.watch(_dataDetailAyat).namaLatin,
                                        teksArab: ref.watch(_dataDetailAyat).ayat[index].teksArab.toString(),
                                        nomorAyat: ref.watch(_dataDetailAyat).ayat[index].nomorAyat.toString(), 
                                        teksLatin: ref.watch(_dataDetailAyat).ayat[index].teksLatin.toString(),
                                        teksIndonesia: ref.watch(_dataDetailAyat).ayat[index].teksIndonesia.toString(),
                                      );
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
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ThemeBox.defaultWidthBox10,
                      ),
                      child: Expanded(
                        child: GestureDetector(
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
                          onTap: (){
                            Future.delayed(Duration.zero,() async{
                              await ref.watch(fetchDataDetailSurahRiverpod.notifier).fetchDataDetailSurah(nomor: nomor);
                              ref.read(_dataDetailAyat.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).detailSurah;
                              ref.read(isLoadingFetchDataDetailSurahRiverpod.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).state;
                              Future.delayed(const Duration(milliseconds: 1000), (){
                                ref.read(isLoadingFetchDataDetailSurahRiverpod.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).state;
                              });
                            });
                            ref.read(_statusDetailSurah.notifier).state = true;
                          },
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
                        child: (ref.watch(_dataDetailTafsir).tafsir.length == 0)
                        ? Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200))
                        : ListView.builder(
                          itemCount: ref.watch(_dataDetailTafsir).tafsir.length,
                          itemBuilder: (context, index){
                            return Row(
                              children: [
                                Expanded(
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
                                        Text("Ayat ${ref.watch(_dataDetailTafsir).tafsir[index].ayat}"),
                                        Text(ref.watch(_dataDetailTafsir).tafsir[index].teks),
                                      ],
                                    ),
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
            ],
          )
      ),
    );
  }
}