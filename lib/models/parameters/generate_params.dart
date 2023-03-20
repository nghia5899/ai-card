import 'package:ai_ecard/models/parameters/base_params.dart';

class GenerateParameter extends BaseParameter {

  String prompt;
  int imageNumber;
  String size;

  GenerateParameter(this.prompt, this.imageNumber, this.size);


  factory GenerateParameter.fromJson(Map<String, dynamic> json){
    return GenerateParameter(
        json['prompt'],
        json['n'],
        json['size'],
    );
  }


  @override
  Map<String, dynamic> build() {
    params['prompt'] = prompt;

    params['n'] = imageNumber;
    params['size'] = size;
    return super.build();
  }
}
