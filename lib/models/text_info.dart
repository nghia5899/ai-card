import 'package:ai_ecard/import.dart';

class TextInfo{
  String? text;
  double? positionTop;
  double? positionLeft;
  Color? color;
  FontWeight? fontWeight;
  double? fontSize;
  TextAlign? textAlign;
  TextStyle? textStyle;
  FontStyle? fontStyle;

  TextInfo({this.text, this.positionTop=0, this.positionLeft, this.color, this.fontWeight, this.fontSize, this.textAlign, this.textStyle, this.fontStyle});

  @override
  String toString() {
    // TODO: implement toString
    return 'text:==========$text';
  }
}