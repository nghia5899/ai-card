import 'package:ai_ecard/import.dart';
import 'package:flutter/material.dart';

class TextInfo {
  String? text;
  double positionTop;
  double positionLeft;
  Color color;
  FontWeight fontWeight;
  double fontSize;
  TextAlign? textAlign;
  TextStyle? textStyle;
  FontStyle? fontStyle;
  String? fontFamily;

  TextInfo(
      {this.text,
      this.positionTop = 0,
      this.positionLeft = 0,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w400,
      this.fontSize = 14,
      this.textAlign,
      this.textStyle,
      this.fontStyle,
      this.fontFamily});

  @override
  String toString() {
    // TODO: implement toString
    return 'text:==========$text';
  }

  TextInfo copyWith({
    String? text,
    double? positionTop,
    double? positionLeft,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextAlign? textAlign,
    TextStyle? textStyle,
    FontStyle? fontStyle,
    String? fontFamily,
  }) {
    return TextInfo(
      text: text ?? this.text,
      positionTop: positionTop ?? this.positionTop,
      positionLeft: positionLeft ?? this.positionLeft,
      color: color ?? this.color,
      fontWeight: fontWeight ?? this.fontWeight,
      fontSize: fontSize ?? this.fontSize,
      textAlign: textAlign ?? this.textAlign,
      textStyle: textStyle,
      fontStyle: fontStyle ?? this.fontStyle,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }
}
