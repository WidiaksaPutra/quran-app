import 'package:http/http.dart' as https;

class Api {
  static String linkUrl = "https://equran.id";
  static String baseApi = "$linkUrl/api/v2";
  static var client = https.Client();
}