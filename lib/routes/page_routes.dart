import 'package:app_quran/ui/detail.dart';
import 'package:app_quran/ui/menu_home.dart';
import 'package:app_quran/routes/route_name.dart';
import 'package:app_quran/splashscreen/splash_screen.dart';
import 'package:app_quran/ui/save_ayat.dart';
import 'package:go_router/go_router.dart';

abstract class AppRoutes{
  static GoRouter pages = GoRouter(
    routes: [
      GoRoute(path: RouteName.splashScreen, builder: (context, state) => const SplashScreen()),
      GoRoute(path: RouteName.menuHome, builder: (context, state) => MenuHome()),
      GoRoute(path: RouteName.detailSurah, builder: (context, state) => Detail()),
      GoRoute(path: RouteName.saveAyat, builder: (context, state) => SaveAyat()),
    ]
  );
}