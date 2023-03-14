import 'package:ai_ecard/import.dart';
import 'package:flutter/material.dart';

class HomeDetailFilterController extends GetxController{

  List<Map> orientations = [
    {
      'title': 'Vertical',
      'image': '',
      'code': 'vertical'
    },{
      'title': 'Horizontal',
      'image': '',
      'code': 'horizontal'
    },{
      'title': 'square',
      'image': '',
      'code': 'square'
    },
  ];

  Map<String,dynamic> filters = {};

  Map<String,Color>  colors = {
    '1': Color(int.parse('0xffEA2027')),
    '2': Color(int.parse('0xff006266')),
    '3': Color(int.parse('0xff1B1464')),
    '4': Color(int.parse('0xff5758BB')),
    '5': Color(int.parse('0xff6F1E51')),
    '6': Color(int.parse('0xffB53471')),
    '7': Color(int.parse('0xffEE5A24')),
    '8': Color(int.parse('0xff009432')),
    '9': Color(int.parse('0xff0652DD')),
    '10': Color(int.parse('0xff9980FA')),
    '11': Color(int.parse('0xff833471')),
    '12': Color(int.parse('0xff112CBC4')),
    '13': Color(int.parse('0xffFDA7DF')),
    '14': Color(int.parse('0xffED4C67')),
    '15': Color(int.parse('0xffF79F1F')),
    '16': Color(int.parse('0xffA3CB38')),
    '17': Color(int.parse('0xff1289A7')),
    '18': Color(int.parse('0xffD980FA')),
    '19': Colors.black,
    '20': Colors.white,
  };

  void operator []=(key, value) {
    filters[key] = value;
    update();
  }

  dynamic operator [](value) {
    if(filters.containsKey(value)){
      return filters[value];
    }
    return '';
  }
}