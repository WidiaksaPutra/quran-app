// ignore_for_file: use_super_parameters, non_constant_identifier_names
import 'package:app_quran/shared/theme_box.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ComponenLoadingLottieBasic extends StatelessWidget {
  final double height;
  const ComponenLoadingLottieBasic({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        "asset/animations/loading_basic_lottie.json",
        height: height,
      ),
    );
  }
}

class ComponenLoadingLottieHorizontal extends StatelessWidget {
  final double height;
  const ComponenLoadingLottieHorizontal({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "asset/animations/loading_horizontal_lottie.json",
      height: height,
    );
  }
}

mixin LoadingScrollData{
  Widget LoadingScrollHeight({
    required bool loadingScrollName, 
    required double withLoading, 
    required double heightLoading, 
    required double rightLoading,
    required BuildContext context,
  }){
    return (loadingScrollName)
    ? Positioned(
        right: rightLoading,
        child: SizedBox(
          height: heightLoading,
          width: withLoading,
          child: Center(
            child: ComponenLoadingLottieHorizontal(height: ThemeBox.defaultHeightBox100),
          ),
        )
      )
    : const Text("");
  }
}