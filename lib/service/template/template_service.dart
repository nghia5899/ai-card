import 'package:ai_ecard/models/models/template/template_model.dart';

class TemplateService {
  static final List<TemplateModel> templates =
      TemplateModel().formListJson(_templates);
  static final List<Map<String, dynamic>> _templates = [
    {
      "code": "1",
      "title": "Monogram Terracota",
      "type": "Fresh",
      "image": "assets/images/template/img_t1.png",
      "category": "birthday",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c1,
    },
    {
      "code": "2",
      "title": "Monogram Terracota",
      "type": "Fresh",
      "image": "assets/images/template/img_t2.png",
      "category": "birthday",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c1,
    },
    {
      "code": "3",
      "title": "Monogram Terracota",
      "type": "kids",
      "image": "assets/images/template/img_t3.png",
      "category": "birthday",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c1,
    },
    {
      "code": "4",
      "title": "Monogram Terracota",
      "type": "Fresh",
      "image": "assets/images/template/img_t4.png",
      "category": "wedding",
      "orientation": OrientationTemp.horizontal,
      "color": HashColor.c1
    },
    {
      "code": "5",
      "title": "Monogram Terracota",
      "type": "kids",
      "image": "assets/images/template/img_t5.png",
      "category": "wedding",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c1
    },
    {
      "code": "6",
      "title": "Monogram Terracota",
      "type": "Kids",
      "image": "assets/images/template/img_t6.png",
      "category": "wedding",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c2
    },
    {
      "code": "7",
      "title": "Monogram Terracota",
      "type": "Anime",
      "image": "assets/images/template/img_t7.png",
      "category": "holiday",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c2
    },
    {
      "code": "8",
      "title": "Monogram Terracota",
      "type": "baby",
      "image": "assets/images/template/img_t8.png",
      "category": "holiday",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c2
    },
    {
      "code": "9",
      "title": "Monogram Terracota",
      "type": "kids",
      "image": "assets/images/template/img_t9.png",
      "category": "holiday",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c2
    },
    {
      "code": "10",
      "title": "Monogram Terracota",
      "type": "baby",
      "image": "assets/images/template/img_t10.png",
      "category": "birthday",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c3
    },
    {
      "code": "11",
      "title": "Monogram Terracota",
      "type": "baby",
      "image": "assets/images/template/img_t11.png",
      "category": "birthday",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c3
    },
    {
      "code": "12",
      "title": "Monogram Terracota",
      "type": "baby",
      "image": "assets/images/template/img_t12.png",
      "category": "new_baby",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c3
    },
    {
      "code": "13",
      "title": "Monogram Terracota",
      "type": "baby",
      "image": "assets/images/template/img_t13.png",
      "category": "new_baby",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c3
    },
    {
      "code": "14",
      "title": "Monogram Terracota",
      "type": "Anime",
      "image": "assets/images/template/img_t14.png",
      "category": "new_baby",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c4
    },
    {
      "code": "15",
      "title": "Monogram Terracota",
      "type": "Anime",
      "image": "assets/images/template/img_t15.png",
      "category": "birthday",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c4
    },
    {
      "code": "16",
      "title": "Monogram Terracota",
      "type": "Kids",
      "image": "assets/images/template/img_t16.png",
      "category": "birthday",
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c4
    },
    {
      "code": "17",
      "title": "Monogram Terracota",
      "type": "Kids",
      "image": "assets/images/template/img_t16.png",
      "category": "birthday",
      "premium": '1',
      "orientation": OrientationTemp.horizontal,
      "color": HashColor.c1
    },
    {
      "code": "18",
      "title": "Monogram Terracota",
      "type": "Kids",
      "image": "assets/images/template/img_t16.png",
      "category": "thank_you",
      "premium": '1',
      "orientation": OrientationTemp.vertical,
      "color": HashColor.c1
    },
    {
      "code": "19",
      "title": "Monogram Terracota",
      "type": "Kids",
      "image": "assets/images/template/img_t16.png",
      "category": "thank_you",
      "premium": '1',
      "orientation": OrientationTemp.square,
      "color": HashColor.c1
    },
  ];
}
