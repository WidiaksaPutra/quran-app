import 'package:app_quran/routes/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375 , 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.pages,
      ),
    );
  }
}