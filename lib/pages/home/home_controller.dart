import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  List<Map> texts = [
    {
      'title': 'birthday',
      'category': 'birthday',
    },{
      'title': 'wedding',
      'category': 'wedding',
    },{
      'title': 'lunar year',
      'category': 'lunar_year',
    },{
      'title': 'birthday',
      'category': 'birthday',
    },{
      'title': 'new baby',
      'category': 'new_baby',
    },
  ];

  List<Map> items = [
    {
      'title': 'Birthday',
      'image': 'assets/images/img_birthday.png',
      'category': 'birthday',
      'color': const Color.fromRGBO(158, 51, 51, 0.5),
    },{
      'title': 'Wedding',
      'category': 'wedding',
      'image': 'assets/images/img_birthday.png',
      'color': const Color.fromRGBO(158, 51, 51, 0.5),
    },{
      'title': 'Thank you',
      'category': 'thank_you',
      'image': 'assets/images/img_thank.png',
      'color': const Color.fromRGBO(51, 158, 107, 0.5),
    },{
      'title': 'Anniversary',
      'category': 'anniversary',
      'image': 'assets/images/img_anniversary.png',
      'color': const Color.fromRGBO(51, 113, 158, 0.5),
    },{
      'title': 'New baby',
      'category': 'new_baby',
      'image': 'assets/images/img_new_baby.png',
      'color': const Color.fromRGBO(156, 156, 156, 0.5),
    },{
      'title': 'New home',
      'category': 'new_home',
      'image': 'assets/images/img_new_home.png',
      'color': const Color.fromRGBO(31, 39, 56, 0.5),
    },{
      'title': 'Holidays',
      'category': 'holiday',
      'image': 'assets/images/img_hodidays.png',
      'color': const Color.fromRGBO(66, 134, 197, 0.5),
    },{
      'title': 'Love & Romance',
      'category': 'love_romance',
      'image': 'assets/images/img_love.png',
      'color': const Color.fromRGBO(255, 90, 110, 0.5),
    }
  ];

  String text = '';

  void updateText(String value) {
    text = value;
  }

}