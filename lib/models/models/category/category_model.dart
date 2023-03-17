import 'package:flutter/cupertino.dart';

class CategoryModel {
  String? title;
  String? image;
  String? category;
  Color? color;
  String? greetings;

  CategoryModel({
     this.title,
     this.image,
     this.category,
     this.color,
     this.greetings,
  });


  factory CategoryModel.formJson(Map json){
    return CategoryModel(title: json['title'], image: json['image'], category: json['category'], color: json['color'],greetings: json['greetings']);
  }

  List<CategoryModel> formListJson(List<Map> list){
    final List<CategoryModel> lists = <CategoryModel>[];
    for (Map element in list) {
      lists.add(CategoryModel.formJson(element));
    }
    return lists;
  }

  Map<String, dynamic> toJson() => _categoryToJson(this);

  Map<String, dynamic> _categoryToJson(CategoryModel instance) {
    return {
      'title': instance.title,
      'image': instance.image,
      'category': instance.category,
      'color': instance.color,
      'greetings': instance.greetings
    };
  }

}
