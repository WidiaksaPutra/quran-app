// ignore_for_file: must_be_immutable, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, prefer_const_constructors, use_build_context_synchronously, await_only_futures

import 'package:app_quran/componen/componen_basic_button.dart';
import 'package:app_quran/componen/componen_content_dialog(image_&_title_text_&_button_text).dart';
import 'package:app_quran/componen/componen_loading.dart';
import 'package:app_quran/controller/mixin/mixin_dialog_basic.dart';
import 'package:app_quran/controller/mixin/mixin_size_device.dart';
import 'package:app_quran/controller/riverpod/ayat_sqlite/delete_ayat/delete_ayat_sqlite_riverpod.dart';
import 'package:app_quran/controller/riverpod/detail_surah/fetch_data_detail_surah_riverpod.dart';
import 'package:app_quran/controller/riverpod/ayat_sqlite/get_ayat/get_ayat_sqlite_riverpod.dart';
import 'package:app_quran/controller/riverpod/util/loading_riverpod.dart';
import 'package:app_quran/routes/route_name.dart';
import 'package:app_quran/shared/theme_box.dart';
import 'package:app_quran/shared/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _dataAyat = StateProvider.autoDispose<dynamic>((ref) => null);
final dataNomorSurah = StateProvider.autoDispose<String>((ref) => "");

class SaveAyat extends ConsumerWidget with SizeDevice, DialogBasic{
  SaveAyat({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeBox(context);
    getsizeDevice(context);
    if(ref.watch(_dataAyat) == null){
      Future.delayed(Duration.zero,() async{
        await ref.watch(getAyatSqliteRiverpod.notifier).GetDataAyatSqlite();
        ref.read(_dataAyat.notifier).state = ref.watch(getAyatSqliteRiverpod.notifier).DataAyatSqlite;
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
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ThemeBox.defaultWidthBox10,
                    vertical: ThemeBox.defaultHeightBox10,
                  ),
                  child: Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ThemeBox.defaultHeightBox5,
                      ),
                      decoration: BoxDecoration(
                        color: kPurpleColor,
                        borderRadius: BorderRadius.circular(ThemeBox.defaultRadius15)
                      ),
                      child: const Center(child: Text("Lihat Surat", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)),
                    ),
                  ),
                ),
                onTap: () => context.go(RouteName.menuHome),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ThemeBox.defaultWidthBox13,
                  vertical: ThemeBox.defaultHeightBox13,
                ),
                child: SizedBox(
                  height: sizeHeight - 120.0,
                  child: ListView.builder(
                    itemCount: ref.watch(_dataAyat).length,
                    itemBuilder: (context, index) => Row(
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${ref.watch(_dataAyat)[index]['nomor']}:${ref.watch(_dataAyat)[index]['nomorAyat']}"),
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: ThemeBox.defaultHeightBox10),
                                        child: ComponenBasicButton(
                                          paddingVertical: 0, 
                                          borderRadius: ThemeBox.defaultRadius15, 
                                          content: Text("Hapus", style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.w400),),
                                          onPressed: (){
                                            voidDialogBasic(
                                              margin: EdgeInsets.symmetric(horizontal: ThemeBox.defaultWidthBox30, vertical: MediaQuery.of(context).size.height * 0.3),
                                              padding: EdgeInsets.only(left: ThemeBox.defaultWidthBox30, right: ThemeBox.defaultWidthBox30, top: ThemeBox.defaultHeightBox30),
                                              borderRadius: BorderRadius.circular(ThemeBox.defaultRadius10),
                                              color: kBlackColor6,
                                              context: context, 
                                              closeIconStatus: false,
                                              barrierDismissible: true,
                                              contentDialog: ComponenContentDialog_ImageAndTitleTextAndButtonText(
                                                primaryColor: kRedColor,
                                                image: 'asset/animations/peringatan_lottie.json', 
                                                text: 'Apakah anda ingin menghapus ayat ini ?', 
                                                textButton: 'Hapus',
                                                onTap: () async{
                                                  await ref.watch(deleteAyatSqliteRiverpod.notifier).DeleteDataAyatSqlite(id: '${ref.watch(_dataAyat)[index]['id']}');
                                                  Future.delayed(Duration.zero,() async{
                                                    await ref.watch(getAyatSqliteRiverpod.notifier).GetDataAyatSqlite();
                                                    ref.read(_dataAyat.notifier).state = ref.watch(getAyatSqliteRiverpod.notifier).DataAyatSqlite;
                                                    ref.read(isLoadingFetchDataDetailSurahRiverpod.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).state;
                                                    Future.delayed(const Duration(milliseconds: 1000), (){
                                                      ref.read(isLoadingFetchDataDetailSurahRiverpod.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).state;
                                                    });
                                                  });
                                                  Navigator.pop(context);    
                                                },
                                              ), 
                                              onTapCloseDialog: () => Navigator.pop(context),
                                            );
                                          },
                                          primaryColor: kRedColor, 
                                          secondaryColor: kGreyColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(ref.watch(_dataAyat)[index]['teksArab'].toString()),
                                  Text(ref.watch(_dataAyat)[index]['teksLatin'].toString()),
                                  Text(ref.watch(_dataAyat)[index]['teksIndonesia'].toString()),
                                ],
                              ),
                            ),
                            onTap: () async {
                              print("test nomor ayat ${ref.watch(_dataAyat)![index]['nomor'].toString()}");
                              // ref.read(dataNomorSurah.notifier).state = await ref.watch(_dataAyat)![index]['nomor'].toString();
                              // Future.delayed(Duration(milliseconds: 1000));
                              // if(ref.watch(dataNomorSurah) != ""){
                              //   context.go(RouteName.detailSurah);
                              // }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}