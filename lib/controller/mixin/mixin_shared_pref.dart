import 'package:shared_preferences/shared_preferences.dart';

mixin SharedPref{
  late SharedPreferences prefs;
  Future<void> sharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }
}