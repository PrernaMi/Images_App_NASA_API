import 'dart:ui';

import 'package:flutter/material.dart';

class AppConst{
  static TextStyle mTextStyle13({Color color = Colors.black}){
    return TextStyle(
      color: color,
      fontSize: 13
    );
  }

  static TextStyle mTextStyleBold({Color color = Colors.black}){
    return TextStyle(
      fontSize: 13,
      color: color,
      fontFamily: "Dark"
    );
  }
}