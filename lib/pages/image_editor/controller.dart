import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/text_info.dart';

class ImageEditorController extends GetxController{
  final List<dynamic>? images;
  ImageEditorController({this.images});

  List<TextInfo> texts = [];
  int index = 0;

  List<String> image = [];

  @override
  void onInit() {
    // TODO: implement onInit
    _init();
    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }


  _init(){
    print('111111111111111111111===========${images}');
    if(!empty(images)){
      for (var element in images!) {
        if(!empty(element)){
          image.add(element['image_url']);
        }
      }

    }
  }

}