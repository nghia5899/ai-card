import 'package:flutter/material.dart';

class TemplateModel {
  String? code;
  String? title;
  String? type;
  String? image;
  String? category;
  HashColor? color;
  OrientationTemp? orientation;
  String? premium;

  TemplateModel(
      {this.title,
      this.image,
      this.type,
      this.category,
      this.code,
      this.color,
      this.orientation,
      this.premium
      });

  factory TemplateModel.formJson(Map json) {
    return TemplateModel(
      title: json['title'],
      image: json['image'],
      category: json['category'],
      color: json['color'],
      type: json['type'],
      orientation: json['orientation'],
      code: json['code'],
      premium: json['premium'],
    );
  }

  List<TemplateModel> formListJson(List<Map> list) {
    final List<TemplateModel> lists = <TemplateModel>[];
    for (Map element in list) {
      lists.add(TemplateModel.formJson(element));
    }
    return lists;
  }

  Map<String, dynamic> toJson() => _categoryToJson(this);

  Map<String, dynamic> _categoryToJson(TemplateModel instance) {
    return {
      'title': instance.title,
      'image': instance.image,
      'category': instance.category,
      'color': instance.color,
      'code': instance.code,
      'type': instance.type,
      'orientation': instance.orientation,
      'premium': instance.premium,
    };
  }
}

enum HashColor { c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11 }

enum OrientationTemp { vertical, horizontal, square}

class ColorTemplate {
  ColorTemplate();

  static final c1 = Color(int.parse('0xffE85F59'));
  static final c2 = Color(int.parse('0xffEFA543'));
  static final c3 = Color(int.parse('0xffF4C9C3'));
  static final c4 = Color(int.parse('0xffF7DC8B'));
  static final c5 = Color(int.parse('0xff73CF9A'));
  static final c6 = Color(int.parse('0xffA2D1EB'));
  static final c7 = Color(int.parse('0xff3571E3'));
  static final c8 = Color(int.parse('0xff8080EA'));
  static final c9 = Color(int.parse('0xff1F262C'));
  static final c10 = Color(int.parse('0xffBDC8D2'));
  static final c11 = Color(int.parse('0xffFFFFFF'));
  // static final c12 = Color(int.parse('0xff112CBC4'));
  // static final c13 = Color(int.parse('0xffFDA7DF'));
  // static final c14 = Color(int.parse('0xffED4C67'));
  // static final c15 = Color(int.parse('0xffF79F1F'));
  // static final c16 = Color(int.parse('0xffA3CB38'));
  // static final c17 = Color(int.parse('0xff1289A7'));
  // static final c18 = Color(int.parse('0xffD980FA'));
  // static const c19 = Colors.black;
  // static const c20 = Colors.white;
}

Map<HashColor, Color> colors = {
  HashColor.c1: ColorTemplate.c1,
  HashColor.c2: ColorTemplate.c2,
  HashColor.c3: ColorTemplate.c3,
  HashColor.c4: ColorTemplate.c4,
  HashColor.c5: ColorTemplate.c5,
  HashColor.c6: ColorTemplate.c6,
  HashColor.c7: ColorTemplate.c7,
  HashColor.c8: ColorTemplate.c8,
  HashColor.c9: ColorTemplate.c9,
  HashColor.c10: ColorTemplate.c10,
  HashColor.c11: ColorTemplate.c11,
};
