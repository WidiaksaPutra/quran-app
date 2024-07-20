import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin SizeDevice{
  late MediaQueryData mediaQuery;
  late double sizeHeight, sizeWidth;
  void getsizeDevice(BuildContext context){
    mediaQuery = MediaQuery.of(context);
    sizeHeight = mediaQuery.size.height;
    sizeWidth = mediaQuery.size.width;
  }

  double getHaight(double inputHeight){
    // if (sizeHeight <= 480.0.h) {
    //   return (inputHeight / 393.0).h * sizeHeight;
    // } else if (sizeHeight > 480.0.h && sizeHeight <= 600.0.h) {
    //   return (inputHeight / 534.0).h * sizeHeight;
    // } else if (sizeHeight > 600.0.h && sizeHeight <= 840.0.h){
    //   return (inputHeight / 732.0).h * sizeHeight;
    // } else if(sizeHeight > 840.0.h && sizeHeight <= 960.0.h) {
    //   return (inputHeight / 879.0).h * sizeHeight;
    // } else if(sizeHeight > 960.0.h && sizeHeight < 1280.0.h){
    //   return (inputHeight / 1080.0).h * sizeHeight;
    // } else if(sizeHeight >= 1280.0.h && sizeHeight <= 1600.0.h){
    //   return (inputHeight / 1280.0).h * sizeHeight;
    // } else {
    //   return (inputHeight / 1707.0).h * sizeHeight;
    // }
    if (sizeHeight <= 450) {
      return (inputHeight / 612.0) * sizeHeight;
    } else if (sizeHeight >= 650 && sizeHeight < 1000) {
      return (inputHeight / 712.0) * sizeHeight;
    } else {
      return (inputHeight / 812.0) * sizeHeight;
    }
  }

  double getWidth(double inputWidth){
    // if (sizeWidth <= 480.0.w) {
    //   return (inputWidth / 393.0).w * sizeWidth;
    // } else if (sizeWidth > 480.0.w && sizeWidth <= 600.0.w) {
    //   return (inputWidth / 534.0).w * sizeWidth;
    // } else if (sizeWidth > 600.0.w && sizeWidth <= 840.0.w){
    //   return (inputWidth / 732.0).w * sizeWidth;
    // } else if(sizeWidth > 840.0.w && sizeWidth <= 960.0.w) {
    //   return (inputWidth / 879.0).w * sizeWidth;
    // } else if(sizeWidth > 960.0.w && sizeWidth < 1280.0.w){
    //   return (inputWidth / 1080.0).w * sizeWidth;
    // } else if(sizeWidth >= 1280.0.w && sizeWidth <= 1600.0.w){
    //   return (inputWidth / 1280.0).w * sizeWidth;
    // } else {
    //   return (inputWidth / 1707.0).w * sizeWidth;
    // }
    // double screenWidth = SizeConfig.screenWidth;
    return (inputWidth / 375.0) * sizeWidth;
  }

  bool getWidthVisiblePortrait(){
    if(sizeWidth < 360.0.w) {
      return false;
    } else{
      return true;
    }
  }

  bool getHeightVisiblePortrait(){
    if(sizeHeight < 670.0.h) {
      return false;
    } else{
      return true;
    }
  }

  bool getWidthVisibleLanscape(){
    if(sizeWidth < 390.0.w) {
      return false;
    } else{
      return true;
    }
  }

  bool getHeightVisibleLanscape(){
    if(sizeHeight < 300.0.h) {
      return false;
    } else{
      return true;
    }
  }
}
