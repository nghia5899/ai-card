import 'dart:typed_data';

import 'package:ai_ecard/models/edit/edit_state.dart';
import 'package:ai_ecard/models/text_info.dart';

class EditModel{

  List<EditState> stack = [];
  Uint8List image;
  List<TextInfo> texts = [];
  int stackIndex = 0;
  EditModel({required this.stack, required this.image, required this.texts});

  void addToStack(){
    stackIndex += 1;
    List<TextInfo> value = [];
    for(int i = 0; i < texts.length; i++) {
      value.add(texts[i].copyWith());
    }
    List<int> imageValue = image.toList();
    List<int> copy = [...imageValue];
    stack.add(EditState(Uint8List.fromList(copy), value));
  }

  void undo(){
    if(stackIndex > 0){
      stackIndex -= 1;
      image = stack[stackIndex].image;
      texts = stack[stackIndex].textInfo;
    }
  }

  void redo(){
    if(stackIndex > 0){
      stackIndex -=1;
      image = stack[stackIndex].image;
      texts = stack[stackIndex].textInfo;
    }
  }
}
