import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/models/template/template_model.dart';
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

  String currentTab = 'For her';

  List<String> _bookMark = [];
  List<TextInfo> listText = [
    // TextInfo(
    //   text: 'Chúc mừng',
    //   positionTop: 150,
    //   textStyle: const TextStyle(color: Colors.black,fontSize: 30,fontFamily: 'LemonJelly',),
    //   positionLeft: Get.width/3,
    //   fontSize: 54
    // ),
    TextInfo(
      text: 'Emily`s 5TH',
      positionTop: 333,
      positionLeft: 109,
      textStyle: const TextStyle(color:Color(0xffFCA940),fontSize: 12,fontFamily: 'OpenSans',),
      fontSize: 24,
      textAlign: TextAlign.center
    ),
    TextInfo(
      text: 'Birthday\nparty',
      positionTop: 374,
      positionLeft: 99,
      textStyle: const TextStyle(color: Color(0xffFCA940),fontSize: 16,fontFamily: 'Oswald',height: 0.5),
      fontSize: 44,
      textAlign: TextAlign.center
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

  Map<String,dynamic> filters = {};

  late List<TemplateModel> _prepareSelect = [];

  List<TemplateModel> _listSelectAll = [];

  List<TemplateModel> get listSelectAll => _listSelectAll;


  _selectAll({String? type}) {
     Map params = (Get.arguments is Map)?Get.arguments:{};
     List<TemplateModel> temp = [...TemplateService.templates];
     if(!empty(params['category'])){
       String category = params['category'].toString();
       _prepareSelect.clear();
         temp = temp.where((TemplateModel obj) => obj.category == category).toList();
         if(!empty(type)){
           if(type == 'For her'){
             prepareList(temp);
           }else{
             temp = temp.where((TemplateModel obj) => obj.type == type).toList();
             prepareList(temp);
           }
         }
         prepareList(temp);
     }else{
       if(!empty(params['filter'])){
         String filter = params['filter'].toString();
         temp = temp.where((TemplateModel obj) => obj.category == filter).toList();
         prepareList(temp);

       }else{
         prepareList(temp);
       }
     }

     update();

   }

   selectAll({String? type}) async{
    showLoading();
    await _selectAll(type: type);
    disableLoading();
   }

  prepareList(List<TemplateModel> items){
     _listSelectAll = items;
     _prepareSelect = items;
  }

   prefilter({Map? filters}){
     if(!empty(filters)){
       _listSelectAll = [..._prepareSelect];
       filters!.forEach((key, value) {
         if(!empty(value)){
           _listSelectAll = _listSelectAll.where((TemplateModel obj) {
             if(!empty(obj.toJson()[key])){
               return obj.toJson()[key].toString() == value.toString();
             }else if(value == '0'){
               return true;
             }
             return false;
           }).toList();
         }
       });
     }else{
       setFilter();
     }

     update();
   }

   setFilter() async{
     _listSelectAll.clear();
     _listSelectAll = [..._prepareSelect];
   }

   clearFilter(){
     selectAll();
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
        showMessage('Remove archive success',type: 'SUCCESS');
      }else{
        temp.add(template);
        showMessage('Archive success',type: 'SUCCESS');
      }
    }else{
      temp.add(template);
      showMessage('Archive success',type: 'SUCCESS');
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

  checkTabCurrent(String tab){
    return currentTab == tab;
  }

}