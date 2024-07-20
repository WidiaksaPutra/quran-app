// ignore_for_file: await_only_futures, non_constant_identifier_names, override_on_non_overriding_member
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

final audioAyatRiverpod = StateNotifierProvider<AudioAyatRiverpod, bool>((ref) {
  final audioAyatNotifier = AudioAyatRiverpod();
  return audioAyatNotifier;
});

class AudioAyatRiverpod extends StateNotifier<bool>{
  AudioAyatRiverpod() : super(false);
  
  @override
  Future<void> AyatAudioPlay({required String url, required AudioPlayer result}) async {
    print("test river audio");
    await result.play(UrlSource(url));
  }

  @override
  Future<void> AyatAudioStop({required AudioPlayer result}) async {
    print("test river pause");
    await result.pause();
  }
}