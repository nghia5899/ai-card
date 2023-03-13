import 'package:ai_ecard/import.dart';
import 'package:flutter/material.dart';

class HomeDetailFilterController extends GetxController{

  List<Map> orientations = [
    {
      'title': 'Vertical',
      'image': '',
    },{
      'title': 'Horizontal',
      'image': '',
    },{
      'title': 'square',
      'image': '',
    },
  ];

  Map<String,dynamic> filters = {};

  List<Color> colors = [
    Color(int.parse('0xffEA2027')),
    Color(int.parse('0xff006266')),
    Color(int.parse('0xff1B1464')),
    Color(int.parse('0xff5758BB')),
    Color(int.parse('0xff6F1E51')),
    Color(int.parse('0xffB53471')),
    Color(int.parse('0xffEE5A24')),
    Color(int.parse('0xff009432')),
    Color(int.parse('0xff0652DD')),
    Color(int.parse('0xff9980FA')),
    Color(int.parse('0xff833471')),
    Color(int.parse('0xff112CBC4')),
    Color(int.parse('0xffFDA7DF')),
    Color(int.parse('0xffED4C67')),
    Color(int.parse('0xffF79F1F')),
    Color(int.parse('0xffA3CB38')),
    Color(int.parse('0xff1289A7')),
    Color(int.parse('0xffD980FA')),
    Colors.black,
    Colors.white,
  ];

  void operator []=(key, value) {
    filters[key] = value;
  }


}