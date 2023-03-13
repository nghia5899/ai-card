import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/models/images/images_model.dart';
import 'package:ai_ecard/models/parameters/generate_params.dart';
import 'package:ai_ecard/pages/image_editor/page.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/service/generate/generate_service.dart';

class GenerateController extends GetxController{

  GenerateService _generateService;

  GenerateController(this._generateService);

  late ImagesModel _imagesModel;

  Map<String,dynamic> fields = {
    'prompt': '',
    'category': 'Painting',
    'width': 512,
    'height': 512,
    'numImages': 2,
  };

  RxDouble currentWidth = 512.0.obs;
  RxDouble currentHeight = 512.0.obs;

  void operator []=(key, value) {
    fields[key] = value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  submit() async{
    // try{
    //   showLoading();
    //   final res = await _generateService.passer(GenerateParameter.fromJson(fields));
    //   disableLoading();
    //   if(!empty(res) && res is Map){
    //     _imagesModel = ImagesModel.formJson(res);
    //     print('$_imagesModel');
    //     // Get.put(ImageEditorPage(images: _imagesModel,));
    //     Get.toNamed(AppRoutes.imageEditor,arguments: _imagesModel);
    //   }
    // }catch (e){
    //   disableLoading();
    // }
    showLoading();
    // final res = await _generateService.passer(GenerateParameter.fromJson(fields));
    // disableLoading();

     await Future.delayed( const Duration(seconds: 3),);
     disableLoading();
    final res = {
      "prompt": "city city in future",
      "history_id": "deff1299-79b8-45c6-8475-cf6922b4aeff",
      "images": [
        {
          "id": "71c32f25-60dc-4384-959f-c6e91c0b0236",
          "image_url": "https://photosonic.s3.amazonaws.com/71c32f25-60dc-4384-959f-c6e91c0b0236.png",
          "full_enhanced_image_url": null,
          "face_enhanced_image_url": null
        },
        {
          "id": "03e87826-403e-4343-b740-efa6e95d719b",
          "image_url": "https://photosonic.s3.amazonaws.com/03e87826-403e-4343-b740-efa6e95d719b.png",
          "full_enhanced_image_url": null,
          "face_enhanced_image_url": null
        }
      ]
    };
    print(res);
    if(!empty(res) && res is Map){
      _imagesModel = ImagesModel.formJson(res);
      print('$_imagesModel');
      // // Get.put(ImageEditorPage(images: _imagesModel,));
      // // Get.toNamed(AppRoutes.imageEditor,arguments: _imagesModel);
      Get.toNamed(AppRoutes.imageViews,arguments: _imagesModel.images);
    }

  }

}