import 'package:allo/constants/app_colors.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomFlushbar {
  static void showFlushbar(
      {required BuildContext context, required String message, String? title}) {
    Flushbar(
      message: message,
      icon: Icon(
        Icons.error,
        size: 28.0,
        color: Colors.white,
      ),
      title: title,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(20),
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      backgroundColor: AppColors.danger,
    )..show(context);
  }
}
