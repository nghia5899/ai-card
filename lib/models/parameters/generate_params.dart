import 'package:ai_ecard/models/parameters/base_params.dart';

class GenerateParameter extends BaseParameter {

  String prompt;
  int width;
  int height;

  GenerateParameter(this.prompt, this.width, this.height);


  factory GenerateParameter.fromJson(Map<String, dynamic> json){
    return GenerateParameter(
        json['prompt'],
        json['width'],
        json['height'],
    );
  }


  @override
  Map<String, dynamic> build() {
    params['prompt'] = prompt;

    params['image_width'] = width;
    params['image_height'] = height;
    return super.build();
  }
}
