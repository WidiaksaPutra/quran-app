// ignore_for_file: must_be_immutable, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, await_only_futures, use_build_context_synchronously, invalid_use_of_internal_member, no_leading_underscores_for_local_identifiers, prefer_const_constructors, unnecessary_null_comparison

import 'package:app_quran/componen/componen_content_dialog(image_&_text).dart';
import 'package:app_quran/componen/componen_content_dialog(image_&_title_text_&_button_text).dart';
import 'package:app_quran/componen/componen_loading.dart';
import 'package:app_quran/controller/mixin/mixin_dialog_basic.dart';
import 'package:app_quran/controller/riverpod/audio_ayat/audio_ayat_riverpod.dart';
import 'package:app_quran/controller/riverpod/detail_surah/fetch_data_detail_surah_riverpod.dart';
import 'package:app_quran/controller/riverpod/detail_tafsir/fetch_data_detail_tafsir_riverpod.dart';
import 'package:app_quran/controller/riverpod/ayat_sqlite/insert_ayat/insert_ayat_sqlite_riverpod.dart';
import 'package:app_quran/controller/riverpod/util/loading_riverpod.dart';
import 'package:app_quran/routes/route_name.dart';
import 'package:app_quran/shared/theme_box.dart';
import 'package:app_quran/shared/theme_color.dart';
import 'package:app_quran/shared/theme_font.dart';
import 'package:app_quran/shared/theme_text_style.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _statusDetailSurah = StateProvider.autoDispose<bool>((ref) => true);
final _dataDetailAyat = StateProvider.autoDispose<dynamic>((ref) => null);
final _dataDetailTafsir = StateProvider.autoDispose<dynamic>((ref) => null);
final _audioPlay = StateProvider.autoDispose<bool>((ref) => false);
final _audioPlayer = StateProvider.autoDispose<AudioPlayer>((ref) => AudioPlayer());
class Detail extends ConsumerWidget with DialogBasic{
  Detail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String _nomor = ref.watch(dataNomorSurah).toString();
    final bool _boolPlay = ref.watch(_audioPlay);
    final AudioPlayer _playAudio = ref.watch(_audioPlayer);
    late String _namaLatin, _tempatTurun, _jumlahAyat, _arti, _nama;
    
    if(ref.watch(_dataDetailAyat) == null){
      if(ref.watch(_statusDetailSurah) == true){
        Future.delayed(Duration.zero,() async{
          ref.read(_audioPlayer.notifier).state = await AudioPlayer();
          await ref.watch(fetchDataDetailSurahRiverpod.notifier).FetchDataDetailSurah(nomor: _nomor);
          ref.read(_dataDetailAyat.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).DetailSurah;
          ref.read(isLoadingFetchDataDetailSurahRiverpod.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).state;
          Future.delayed(const Duration(milliseconds: 1000), (){
            ref.read(isLoadingFetchDataDetailSurahRiverpod.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).state;
          });
        });
      }
    }
    if(ref.watch(_dataDetailAyat) != null){
      _namaLatin = ref.watch(_dataDetailAyat).namaLatin.toString();
      _tempatTurun = ref.watch(_dataDetailAyat).tempatTurun.toString();
      _jumlahAyat = ref.watch(_dataDetailAyat).jumlahAyat.toString();
      _arti = ref.watch(_dataDetailAyat).arti.toString();
      _nama = ref.watch(_dataDetailAyat).nama.toString();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: (ref.watch(_dataDetailAyat) == null || ref.watch(isLoadingFetchDataDetailSurahRiverpod) == true)
        ? Flexible(child: Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200)))
        : Column(
            children: [
              GestureDetector(
                onTap: () async{
                  await ref.watch(audioAyatRiverpod.notifier).AyatAudioStop(result: _playAudio);
                  context.go(RouteName.menuHome);
                },
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
                    child: (_namaLatin == null)
                    ? Flexible(child: Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200)))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.arrow_back_ios, color: Colors.white,),
                              Text(_namaLatin, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: defaultFont15),),
                              SizedBox(width: ThemeBox.defaultWidthBox30,)
                            ],
                          ),
                          Text("$_tempatTurun . $_jumlahAyat Ayat . $_arti", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: defaultFont13),),
                          const Divider(),
                          Text(_nama, style: whiteQuranTextStyle.copyWith(fontWeight: FontWeight.w100, fontSize: defaultFont54)),
                        ],
                      )
                  ),
                ),
              ),
              (ref.watch(_statusDetailSurah) == true)
              ? Flexible(
                  child: Column(
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
                                    await ref.watch(fetchDataDetailTafsirRiverpod.notifier).fetchDataDetailSurah(nomor: _nomor);
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
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      (ref.watch(_audioPlay) == true) ? const Icon(Icons.pause, color: kWhiteColor) : Icon(Icons.play_arrow, color: kWhiteColor),
                                      const Text("Play Audio", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),),
                                      const SizedBox()
                                    ],
                                  ),
                                ),
                                onTap: () async{
                                  ref.read(_audioPlay.notifier).state = !_boolPlay;
                                  (ref.watch(_audioPlay) == false)
                                  ? await ref.watch(audioAyatRiverpod.notifier).AyatAudioStop(result: _playAudio)
                                  : await ref.watch(audioAyatRiverpod.notifier).AyatAudioPlay(url: ref.watch(_dataDetailAyat).audioFull['05'], result: _playAudio);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: ThemeBox.defaultHeightBox13,
                            left: ThemeBox.defaultWidthBox13,
                            right: ThemeBox.defaultWidthBox13,
                          ),
                          child: (ref.watch(_dataDetailAyat).ayat.length == 0)
                          ? Flexible(child: Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200)))
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${ref.watch(_dataDetailAyat).nomor}:${ref.watch(_dataDetailAyat).ayat[index].nomorAyat}", style: TextStyle(color: kPurpleColor, fontWeight: FontWeight.w600)),
                                            SizedBox(height: ThemeBox.defaultHeightBox20,),
                                            Text(ref.watch(_dataDetailAyat).ayat[index].teksArab, style: purpleQuranTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: defaultFont24), textAlign: TextAlign.right,),
                                            SizedBox(height: ThemeBox.defaultHeightBox20,),
                                            Text(ref.watch(_dataDetailAyat).ayat[index].teksLatin),
                                            SizedBox(height: ThemeBox.defaultHeightBox10,),
                                            Text(ref.watch(_dataDetailAyat).ayat[index].teksIndonesia, style: TextStyle(color: kPurpleColor),),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        voidDialogBasic(
                                          padding: EdgeInsets.only(left: ThemeBox.defaultWidthBox30, right: ThemeBox.defaultWidthBox30, bottom: ThemeBox.defaultHeightBox30),
                                          borderRadius: BorderRadius.circular(ThemeBox.defaultRadius10),
                                          color: kBlackColor6,
                                          context: context, 
                                          closeIconStatus: false,
                                          barrierDismissible: true,
                                          autoClose: false,
                                          contentDialog: ComponenContentDialog_ImageAndTitleTextAndButtonText(
                                            primaryColor: kGreenColor,
                                            image: 'asset/animations/peringatan_lottie.json', 
                                            text: 'Apakah anda ingin menyimpan ayat ini ?', 
                                            textButton: 'Simpan',
                                            onTap: () async{
                                              await ref.watch(insertAyatSqliteRiverpod.notifier).InsertDataAyatSqlite(
                                                nomor: ref.watch(_dataDetailAyat).nomor.toString(), 
                                                namaLatin: ref.watch(_dataDetailAyat).namaLatin,
                                                teksArab: ref.watch(_dataDetailAyat).ayat[index].teksArab.toString(),
                                                nomorAyat: ref.watch(_dataDetailAyat).ayat[index].nomorAyat.toString(), 
                                                teksLatin: ref.watch(_dataDetailAyat).ayat[index].teksLatin.toString(),
                                                teksIndonesia: ref.watch(_dataDetailAyat).ayat[index].teksIndonesia.toString(),
                                              );
                                              Navigator.pop(context);
                                              (ref.watch(insertAyatSqliteRiverpod.notifier).StatusInsertSqlite == true)
                                              ? voidDialogBasic(
                                                  padding: EdgeInsets.only(left: ThemeBox.defaultWidthBox30, right: ThemeBox.defaultWidthBox30, bottom: ThemeBox.defaultHeightBox30),
                                                  borderRadius: BorderRadius.circular(ThemeBox.defaultRadius10),
                                                  color: kBlackColor6,
                                                  context: context, 
                                                  closeIconStatus: false,
                                                  barrierDismissible: true,
                                                  autoClose: true,
                                                  contentDialog: ComponenContentDialog_ImageAndTitleText(
                                                    image: 'asset/animations/check_lottie.json', 
                                                    text: 'Ayat Berhasil Disimpan',
                                                  ),
                                                  onTapCloseDialog: () => Navigator.pop(context),
                                                )
                                              : voidDialogBasic(
                                                  padding: EdgeInsets.only(left: ThemeBox.defaultWidthBox30, right: ThemeBox.defaultWidthBox30, bottom: ThemeBox.defaultHeightBox30),
                                                  borderRadius: BorderRadius.circular(ThemeBox.defaultRadius10),
                                                  color: kBlackColor6,
                                                  context: context, 
                                                  closeIconStatus: false,
                                                  barrierDismissible: true,
                                                  autoClose: true,
                                                  contentDialog: ComponenContentDialog_ImageAndTitleText(
                                                    image: 'asset/animations/close_lottie.json', 
                                                    text: 'Ayat Gagal Disimpan',
                                                  ),
                                                  onTapCloseDialog: () => Navigator.pop(context),
                                                );
                                            },
                                          ), 
                                          onTapCloseDialog: () => Navigator.pop(context), 
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
                  ),
                )
              : (ref.watch(_dataDetailTafsir) == null)
                ? Flexible(child: Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200)))
                : Flexible(
                    child: Column(
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
                                await ref.watch(fetchDataDetailSurahRiverpod.notifier).FetchDataDetailSurah(nomor: _nomor);
                                ref.read(_dataDetailAyat.notifier).state = ref.watch(fetchDataDetailSurahRiverpod.notifier).DetailSurah;
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
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: ThemeBox.defaultWidthBox13,
                            right: ThemeBox.defaultWidthBox13,
                            top: ThemeBox.defaultHeightBox13,
                          ),
                          child: (ref.watch(_dataDetailTafsir).tafsir.length == 0)
                          ? Flexible(child: Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200)))
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
                                          Text("Ayat ${ref.watch(_dataDetailTafsir).tafsir[index].ayat}", style: TextStyle(color:kPurpleColor, fontWeight: FontWeight.w600),),
                                          SizedBox(height: ThemeBox.defaultHeightBox10,),
                                          Text(ref.watch(_dataDetailTafsir).tafsir[index].teks, style: TextStyle(color:kPurpleColor),),
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
                  ),
                )
            ],
          )
      ),
    );
  }
}