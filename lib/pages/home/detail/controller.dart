import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/service/template/template_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeDetailController extends GetxController{

  HomeDetailController();

  final List<String> texts = [
    'For her',
    'Fresh',
    'Kids',
    'baby',
    'Anime',
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
  List<String> _bookMark = [];
  List<TextInfo> listText = [
    TextInfo(
      text: 'Chúc mừng',
      positionTop: 150,
      textStyle: const TextStyle(color: Colors.black,fontSize: 30,fontFamily: 'LemonJelly',),
      positionLeft: Get.width/2.5
    ),
    TextInfo(
      text: 'Thanks you',
        positionTop: 200,
        positionLeft: Get.width/2.5,
      textStyle: const TextStyle(color: Colors.black,fontSize: 30,fontFamily: 'LemonJelly',),
    ),
    TextInfo(
      text: 'for your order',
        positionTop: 250,
        positionLeft: Get.width/2.5,
        textStyle: const TextStyle(color: Colors.black,fontSize: 30,fontFamily: 'LemonJelly',),
    ),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    _getBookMark();
    selectAll();
    super.onReady();
  }


  List<Map<String, dynamic>> _listSelectAll = [];

  List<Map<String, dynamic>> get listSelectAll => _listSelectAll;


   selectAll({String? type}) async{
     Map params = (Get.arguments is Map)?Get.arguments:{};
     if(!empty(params['category'])){
       String category = params['category'].toString();
       _listSelectAll = [...TemplateService.templates];
       _listSelectAll.clear();
       List<Map<String, dynamic>> temp = [...TemplateService.templates];
         temp = temp.where((obj) => obj["category"].toString() == category).toList();
         _listSelectAll = temp;
         if(!empty(type)){
           if(type == 'For her'){
             _listSelectAll = TemplateService.templates;
           }else{
             temp = temp.where((obj) => obj["type"].toString() == type).toList();
             _listSelectAll = temp;
           }
         }
     }else{
       if(!empty(params['filter'])){
         String filter = params['filter'].toString();
         List<Map<String, dynamic>> temp = [...TemplateService.templates];
         temp = temp.where((obj) => obj["title"].toString() == filter).toList();
         _listSelectAll = temp;

       }else{
         _listSelectAll = [];
       }
     }

     update();

   }

   _getBookMark() async{
     var prefs = await SharedPreferences.getInstance();

     List<String> bookmarks = prefs.getStringList('bookmark') ?? [];
     if(!empty(bookmarks)){
       _bookMark = bookmarks;
     }
   }

   Future bookMark(String template,{bool reLoad = false}) async {
    List<String> temp = [];
    var prefs = await SharedPreferences.getInstance();

    List<String> bookmarks = prefs.getStringList('bookmark') ?? [];
    if(!empty(bookmarks)){
      temp = [...bookmarks];
      if(bookmarks.contains(template)){
        temp.remove(template);
      }else{
        temp.add(template);
      }
    }else{
      temp.add(template);
    }
    prefs.setStringList('bookmark',temp);
    if(reLoad){
      _bookMark = prefs.getStringList('bookmark') ?? [];
    }
    update();

  }

  checkBookMark(String bookMark){
     return _bookMark.contains(bookMark);
  }

}