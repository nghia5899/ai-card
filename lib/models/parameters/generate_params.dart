import 'package:ai_ecard/models/parameters/base_params.dart';

class GenerateParameter extends BaseParameter {

  String prompt;
  int width;
  int height;
  String category;

  GenerateParameter(this.prompt, this.width, this.height, this.category);


  factory GenerateParameter.fromJson(Map<String, dynamic> json){
    return GenerateParameter(
        json['prompt'],
        json['width'],
        json['height'],
        json['category'],
    );
  }


  @override
  Map<String, dynamic> build() {
    params['prompt'] = prompt;

    params['img_width'] = width;
    params['img_height'] = height;
    params['category'] = category;
    return super.build();
  }
}
