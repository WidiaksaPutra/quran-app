// ignore_for_file: prefer_const_constructors, use_super_parameters, must_be_immutable, camel_case_types
import 'package:app_quran/componen/componen_basic_button.dart';
import 'package:app_quran/shared/theme_box.dart';
import 'package:app_quran/shared/theme_color.dart';
import 'package:app_quran/shared/theme_font.dart';
import 'package:app_quran/shared/theme_text_style.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ComponenContentDialog_ImageAndTitleTextAndButtonText extends StatelessWidget {
  late String image, text, textButton;
  late VoidCallback onTap;
  late Color primaryColor;
  ComponenContentDialog_ImageAndTitleTextAndButtonText({Key? key,
    required this.image,
    required this.text,
    required this.textButton,
    required this.primaryColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            image,
            height: ThemeBox.defaultHeightBox150,
            width: ThemeBox.defaultWidthBox152,
          ),
          Text(text, style: whiteTextStyle.copyWith(fontWeight: semiBold, fontSize: defaultFont18)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ThemeBox.defaultHeightBox10),
            child: ComponenBasicButton(
              paddingVertical: 0, 
              borderRadius: ThemeBox.defaultRadius5, 
              content: Text(textButton, style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.w400),),
              onPressed: onTap, 
              primaryColor: primaryColor,
              secondaryColor: kGreyColor,
            ),
          )
        ],
      ),
    );
  }
}