// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last, deprecated_member_use

import 'package:flutter/material.dart';

class ComponenBasicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double paddingVertical, borderRadius;
  final Widget content;
  final Color primaryColor, secondaryColor;
  const ComponenBasicButton({
    required this.onPressed,
    required this.paddingVertical,
    required this.borderRadius,
    required this.content,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingVertical),
        child: content,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return secondaryColor;
          }
          return primaryColor;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          )
        ),
      ),
    );
  }
}