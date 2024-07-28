// ignore_for_file: prefer_const_constructors, must_be_immutable, invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, prefer_final_fields, await_only_futures, use_build_context_synchronously, prefer_const_constructors_in_immutables, no_leading_underscores_for_local_identifiers

import 'package:app_quran/componen/componen_loading.dart';
import 'package:app_quran/controller/riverpod/list_surah/fetch_data_list_surah_riverpod.dart';
import 'package:app_quran/controller/riverpod/search_surah/fetch_search_data_list_surah_riverpod.dart';
import 'package:app_quran/controller/riverpod/util/loading_riverpod.dart';
import 'package:app_quran/routes/route_name.dart';
import 'package:app_quran/shared/theme_box.dart';
import 'package:app_quran/shared/theme_color.dart';
import 'package:app_quran/shared/theme_font.dart';
import 'package:app_quran/shared/theme_global_variabel.dart';
import 'package:app_quran/shared/theme_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _dataMenuHome = StateProvider.autoDispose<List?>((ref) => null);
// final _contentHeight = StateProvider.autoDispose<double>((ref) => 0.0);
class MenuHome extends ConsumerWidget{
  MenuHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final GlobalKey _keyContinerCardTitle = GlobalKey();
    // final GlobalKey _keyPaddingFilterSearch = GlobalKey();
    // Size mediaQ = MediaQuery.of(context).size;
    if(ref.watch(_dataMenuHome) == null){
      Future.delayed(Duration.zero, () async{
        await ref.watch(fetchDataListSurahRiverpod.notifier).FetchDataListSurah();
        ref.read(_dataMenuHome.notifier).state = ref.watch(fetchDataListSurahRiverpod.notifier).ListSurah;
        ref.read(isLoadingFetchDataListSurahRiverpod.notifier).state = ref.watch(fetchDataListSurahRiverpod.notifier).state;
        Future.delayed(Duration(milliseconds: 1000), (){
          ref.read(isLoadingFetchDataListSurahRiverpod.notifier).state = ref.watch(fetchDataListSurahRiverpod.notifier).state;
        });
      });
    }

    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   final RenderBox _renderBoxContinerCardTitle = _keyContinerCardTitle.currentContext!.findRenderObject() as RenderBox;
    //   final RenderBox _renderBoxPaddingFilterSearch = _keyPaddingFilterSearch.currentContext!.findRenderObject() as RenderBox;
    //   ref.read(_contentHeight.notifier).state = _renderBoxContinerCardTitle.size.height + _renderBoxPaddingFilterSearch.size.height + ThemeBox.defaultHeightBox13;
    //   // + ThemeBox.defaultHeightBox27_62
    // });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: (ref.watch(_dataMenuHome) == null || ref.watch(isLoadingFetchDataListSurahRiverpod) == true)
          ? Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200))
          : Column(
              children: [
                Container(
                  // key: _keyContinerCardTitle,
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
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ThemeBox.defaultHeightBox20),
                        Text(formatDayArab.format(DateTime.now()), style: whiteQuranTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: defaultFont24),),
                        Text(formatDay.format(DateTime.now()), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
                        Text(formatDateShort.format(DateTime.now()), style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  // key: _keyPaddingFilterSearch,
                  padding: EdgeInsets.symmetric(
                    horizontal: ThemeBox.defaultWidthBox10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          style: TextStyle(fontSize: defaultFont12),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: ThemeBox.defaultHeightBox10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(ThemeBox.defaultRadius15),
                                bottomLeft: Radius.circular(ThemeBox.defaultRadius15),
                              ),
                              borderSide: const BorderSide(color: kBlueColor),
                            )
                          ),
                          onChanged: (value){
                            if(value == ""){
                              ref.read(_dataMenuHome.notifier).state = ref.watch(fetchDataListSurahRiverpod.notifier).ListSurah;
                            }else{
                              Future.delayed(Duration.zero, () async{
                                await ref.watch(fetchSearchDataListSurahRiverpod.notifier).SearchDataListSurah(
                                  listDataSurah: ref.watch(fetchDataListSurahRiverpod.notifier).ListSurah!, 
                                  searchSurah: value
                                );
                                ref.read(_dataMenuHome.notifier).state = [];
                                ref.read(_dataMenuHome.notifier).state = ref.watch(fetchSearchDataListSurahRiverpod.notifier).ListSurah;
                                ref.read(isLoadingFetchDataListSurahRiverpod.notifier).state = ref.watch(fetchSearchDataListSurahRiverpod.notifier).state;
                                Future.delayed(Duration(milliseconds: 1000), (){
                                  ref.read(isLoadingFetchDataListSurahRiverpod.notifier).state = ref.watch(fetchSearchDataListSurahRiverpod.notifier).state;
                                });
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(width: ThemeBox.defaultWidthBox5),
                      Expanded(
                        child: GestureDetector(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: ThemeBox.defaultHeightBox12,
                            ),
                            decoration: BoxDecoration(
                              color: kPurpleColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(ThemeBox.defaultRadius15),
                                bottomRight: Radius.circular(ThemeBox.defaultRadius15),
                              ),
                            ),
                            child: Center(child: Text("Book", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),)),
                          ),
                          onTap: () => context.go(RouteName.saveAyat),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: ThemeBox.defaultWidthBox13,
                      right: ThemeBox.defaultWidthBox13,
                      top: ThemeBox.defaultHeightBox13,
                    ),
                    child: 
                    // SizedBox(
                    //   height: mediaQ.height - ref.watch(_contentHeight),
                    //   child: 
                      (ref.watch(isLoadingFetchDataListSurahRiverpod) == true)
                      ? Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200))
                      : ListView.separated(
                          itemCount: ref.watch(_dataMenuHome)!.length,
                          separatorBuilder: (BuildContext context, int index) => Divider(color:Colors.grey),
                          itemBuilder: (context, index){
                            return GestureDetector(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(ref.watch(_dataMenuHome)![index].nomor.toString(), overflow: TextOverflow.ellipsis),
                                      SizedBox(width: ThemeBox.defaultWidthBox10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(ref.watch(_dataMenuHome)![index].namaLatin, style: TextStyle(fontWeight: FontWeight.w900, fontSize: defaultFont16), overflow: TextOverflow.ellipsis,),
                                          Text("${ref.watch(_dataMenuHome)![index].tempatTurun} . ${ref.watch(_dataMenuHome)![index].arti}", style: TextStyle(color: kGreyColor2, fontSize: defaultFont13, fontWeight: FontWeight.w600), maxLines: 3, overflow: TextOverflow.ellipsis,),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Flexible(child: Text(ref.watch(_dataMenuHome)![index].nama, style: purpleQuranTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: defaultFont24), overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                              onTap: () async{
                                ref.read(dataNomorSurah.notifier).state = await ref.watch(_dataMenuHome)![index].nomor.toString();
                                if(ref.watch(dataNomorSurah) != ""){
                                  context.go(RouteName.detailSurah);
                                }
                              }
                            );
                          },
                        ),
                    // ),
                  ),
                ),
              ],
            )
      ),
    );
  }
}