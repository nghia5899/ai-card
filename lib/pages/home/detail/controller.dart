

import 'package:ai_ecard/import.dart';

class HomeDetailController extends GetxController{


  List<String> texts = [
    'For her',
    'For her',
    'For her',
    'For her',
    'For her',
  ];

  static final List<String> images = [
    'assets/images/image1.png',
    'assets/images/image2.png',
    'assets/images/image3.png',
  ];
  List<Map> items = [
    {
      'index': 1,
      'title': 'birthday',
      'image': images
    },{
      'index': 2,
      'title': 'wedding',
      'image': images
    },{
      'index': 3,
      'title': 'lunar year',
      'image': images
    },{
      'index': 4,
      'title': 'lunar year',
      'image': images
    },{
      'index': 5,
      'title': 'lunar year',
      'image': images
    },{
      'index': 6,
      'title': 'lunar year',
      'image': images
    },{
      'index': 7,
      'title': 'lunar year',
      'image': images
    },{
      'index': 8,
      'image': images
    },{
      'index': 9,
      'image': images
    },
  ];
}