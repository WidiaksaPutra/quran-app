
// ignore_for_file: use_super_parameters, must_be_immutable

import 'package:app_quran/controller/mixin/mixin_size_device.dart';
import 'package:app_quran/routes/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget with SizeDevice{
  MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getsizeDevice(context);
    late Size size = MediaQuery.of(context).size;
    late double screenW = size.width;
    late double screenH = size.height;
    return ScreenUtilInit(
      designSize: Size(screenW , screenH),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => ProviderScope(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoutes.pages,
        ),
      ),
    );
  }
}