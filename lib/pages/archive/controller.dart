import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/models/template/template_model.dart';
import 'package:ai_ecard/service/template/template_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArchiveController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  
  @override
  void onReady() {
    getBookMark();
    super.onReady();
  }


  List<TemplateModel>? _items;
  
  List<TemplateModel>? get items => _items;
  
  getBookMark() async {
    List<TemplateModel> temp = [];
    var prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList('bookmark') ?? [];
    if(!empty(bookmarks)){
      for (String element in bookmarks) {
        TemplateService.templates.forEach((e) {
          if(e.code == element){
            temp.add(e);
          }
        });
      }
      _items = temp;
    }else{
      _items = [];
    }
   update();
  }

  Future bookMark(String template, {bool reLoad = false}) async {
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
      await getBookMark();
    }
  }
}