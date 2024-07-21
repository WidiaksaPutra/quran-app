import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingFetchDataListSurahRiverpod = StateProvider.autoDispose<bool>((ref) => false);
final isLoadingFetchDataDetailSurahRiverpod = StateProvider.autoDispose<bool>((ref) => false);
final isLoadingFetchDataDetailTafsirRiverpod = StateProvider.autoDispose<bool>((ref) => false);
final dataNomorSurah = StateProvider.autoDispose<String>((ref) => "");