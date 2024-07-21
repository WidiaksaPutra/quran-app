import 'package:app_quran/shared/theme_box.dart';
import 'package:flutter/material.dart';

mixin DialogBasic{
  void voidDialogBasic({
    required BuildContext context,
    required VoidCallback onTapCloseDialog,
    required Widget contentDialog,
    required bool barrierDismissible,
    required bool closeIconStatus,
    required EdgeInsetsGeometry margin,
    required EdgeInsetsGeometry padding,
    required Color color,
    required BorderRadiusGeometry borderRadius,
    required bool autoClose,
  }){
    ThemeBox(context);
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: ((BuildContext context){
        if(autoClose == true){
          Future.delayed(const Duration(milliseconds: 3000),(){
            Navigator.pop(context);
          });
        }
        return Container(
          margin: margin,
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(closeIconStatus == true)...[
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: onTapCloseDialog,
                    child: Image.asset(
                      'asset/icon/close_icon.png',
                      height: ThemeBox.defaultHeightBox10,
                      width: ThemeBox.defaultWidthBox10,
                    ),
                  ),
                ),
              ],
              Expanded(child: contentDialog),
            ],
          ),
        );
      }
    ));
  }
}
