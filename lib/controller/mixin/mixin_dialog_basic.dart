import 'package:app_quran/shared/theme_box.dart';
import 'package:flutter/material.dart';

mixin DialogBasic{
  void voidDialogBasic({
    required BuildContext context,
    required VoidCallback onTapCloseDialog,
    required Widget contentDialog,
    required bool barrierDismissible,
    required bool closeIconStatus,
    required EdgeInsetsGeometry padding,
    required Color color,
    required BorderRadiusGeometry borderRadius,
    required bool autoClose,
  }){
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: ((BuildContext context){
        if(autoClose == true){
          Future.delayed(const Duration(milliseconds: 3000),(){
            Navigator.pop(context);
          });
        }
        return Dialog(
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                contentDialog
              ],
            ),
          ),
        );
      }
    ));
  }
}
