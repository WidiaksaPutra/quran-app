// ignore_for_file: unused_element, use_super_parameters

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app_quran/componen/componen_loading.dart';
import 'package:app_quran/routes/route_name.dart';
import 'package:app_quran/shared/theme_box.dart';
import 'package:app_quran/shared/theme_color.dart';
import 'package:go_router/go_router.dart';


class SplashScreen extends StatelessWidget{
  const SplashScreen({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => context.go(RouteName.menuHome),);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(child: ComponenLoadingLottieBasic(height: ThemeBox.defaultHeightBox200)),
    );
  }
}