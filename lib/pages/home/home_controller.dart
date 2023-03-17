import 'package:ai_ecard/models/models/category/category_model.dart';
import 'package:ai_ecard/service/category/category_service.dart';
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


  List<CategoryModel> _items = [];
  List<CategoryModel> get items => _items;


  String text = '';

  void updateText(String value) {
    text = value;
  }
  
  @override
  void onReady() {

    super.onReady();
  }
  @override
  void onInit() {
    _init();
    // TODO: implement onInit
    super.onInit();
  }

  _init() async{
    _items = CategoryService.category;
  }

}