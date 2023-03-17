import 'dart:typed_data';

import 'package:ai_ecard/models/edit/edit_state.dart';
import 'package:ai_ecard/models/text_info.dart';
import 'package:flutter/material.dart';

class EditModel {
  List<EditState> stack = [];
  Uint8List image;
  List<TextInfo> texts = [];
  int stackIndex = -1;

  EditModel({required this.image, required this.texts}) {
    addToStack();
  }

  void addToStack() {
    List<TextInfo> value = [];
    for (int i = 0; i < texts.length; i++) {
      value.add(texts[i].copyWith());
    }
    Uint8List imageValue;
    if(isNewStateImage()){
      List<int> copy = image.toList();
      List<int> value = [...copy];
      imageValue = Uint8List.fromList(value);
    } else {
      imageValue = stack[stackIndex].image;
    }

    if (stackIndex >= stack.length - 1) {
      stack.add(EditState(imageValue, value));
      stackIndex = stack.length - 1;
    } else {
      stack.removeRange(stackIndex + 1, stack.length);
      stack.add(EditState(imageValue, value));
      stackIndex = stack.length - 1;
    }
  }

  void undo() {
    if (stackIndex > 0) {
      stackIndex -= 1;
      List<TextInfo> textValue = [];
      for (int i = 0; i < texts.length; i++) {
        textValue.add(stack[stackIndex].textInfo[i].copyWith());
      }
      List<int> copy = stack[stackIndex].image.toList();
      List<int> imageValue = [...copy];
      image = Uint8List.fromList(imageValue);
      texts = textValue;
    }
  }

  void redo() {
    if (stackIndex < stack.length - 1) {
      stackIndex += 1;
      List<TextInfo> textValue = [];
      for (int i = 0; i < texts.length; i++) {
        textValue.add(stack[stackIndex].textInfo[i].copyWith());
      }
      List<int> copy = stack[stackIndex].image.toList();
      List<int> imageValue = [...copy];
      image = Uint8List.fromList(imageValue);
      texts = textValue;
    }
  }

  void updateText(String value, int index) {
    texts[index].text = value;
  }

  void updateColor(Color color, int index) {
    texts[index].color = color;
  }

  void updateAlign(TextAlign align, int index){
    texts[index].textAlign = align;
  }

  void updateFontSize(double fontSize, int index) {
    texts[index].fontSize = fontSize;
  }

  void updateFontFamily(String fontFamily, int index) {
    texts[index].fontFamily = fontFamily;
  }

  void updatePosition(double y, double x, int index) {
    texts[index].positionTop = y;
    texts[index].positionLeft = x;
  }

  void updateImage(Uint8List image) {
    this.image = image;
  }

  bool get undoEnabled => stackIndex > 0;

  bool get redoEnabled => stackIndex < stack.length - 1;

  void resetState() {
    List<TextInfo> textValue = [];
    for (int i = 0; i < texts.length; i++) {
      textValue.add(stack[stackIndex].textInfo[i].copyWith());
    }
    List<int> copy = stack[stackIndex].image.toList();
    List<int> imageValue = [...copy];
    image = Uint8List.fromList(imageValue);
    texts = textValue;
  }

  bool isNewState() {
    if (stack[stackIndex].textInfo.length != texts.length) {
      return true;
    }
    List<TextInfo> textInfo = stack[stackIndex].textInfo;
    for (int i = 0; i < texts.length; i++) {
      if (texts[i].text != textInfo[i].text ||
          texts[i].color.value != textInfo[i].color.value ||
          texts[i].fontSize != textInfo[i].fontSize ||
          texts[i].fontFamily != textInfo[i].fontFamily ||
          texts[i].positionTop != textInfo[i].positionTop ||
          texts[i].positionLeft != textInfo[i].positionLeft) {
        return true;
      }
    }
    return false;
  }

  bool isNewStateImage(){
    if(stackIndex < 0) {
      return true;
    }
    if(image.length != stack[stackIndex].image.length){
      return true;
    }

    for(int i = 0; i < image.length; i++){
      if(image[i] != stack[stackIndex].image[i]){
        return true;
      }
    }
    return false;
  }

  TextAlign? textAlign(index){
    return texts[index].textAlign;
  }
}
