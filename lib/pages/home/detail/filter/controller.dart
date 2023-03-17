import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/models/template/template_model.dart';

class HomeDetailFilterController extends GetxController{
  final Map? params;
  HomeDetailFilterController({ this.params});


  List<Map> orientations = [
    {
      'title': 'Vertical',
      'image': 'assets/icons/ic_vertical.svg',
      'code': OrientationTemp.vertical
    },{
      'title': 'Horizontal',
      'image': 'assets/icons/ic_horizontal.svg',
      'code': OrientationTemp.horizontal
    },{
      'title': 'square',
      'image': 'assets/icons/ic_square.svg',
      'code': OrientationTemp.square
    },
  ];

  Map<String,dynamic> filters = {};

  void operator []=(key, value) {
    if(filters.containsKey(key) && filters[key] == value){
      filters.remove(key);
    }else{
      filters[key] = value;
    }
    update();
  }

  dynamic operator [](value) {
    if(filters.containsKey(value)){
      return filters[value];
    }
    return '';
  }

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  _init(){
    if(!empty(params)){
      params!.forEach((key, value) {
        this[key] = value;
      });

    }
  }
}