// ignore_for_file: non_constant_identifier_names

abstract class InterfaceAyatAudio{
  Future<void> AyatAudioPlay({required String url});
  Future<void> AyatAudioStop();
  bool get StatusAudio;
}