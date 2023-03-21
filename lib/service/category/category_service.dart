import 'package:ai_ecard/models/models/category/category_model.dart';
import 'package:flutter/cupertino.dart';

class CategoryService{

  static final List<CategoryModel> category =
  CategoryModel().formListJson(_category);

  static final List<Map<String, dynamic>> _category = [
    {
      'title': 'Birthday',
      'image': 'assets/images/img_birthday.png',
      'category': 'birthday',
      'color': const Color.fromRGBO(158, 51, 51, 0.5),
      'greetings': 'Happy birthday, HPBD, Birthday flower, Today birthday, Cocomelon cake, Birthday decor, Birthday balloons, birthday ideas, birthday queen, 	birthday candles'
    },{
      'title': 'Wedding',
      'category': 'wedding',
      'image': 'assets/images/img_wedding.png',
      'color': const Color.fromRGBO(158, 128, 51, 0.5),
      'greetings': 'Happy Wedding!!, Wishing you all the health, and happiness in the world, on your wedding., Let good luck and understanding stay with your forever - congratulations!,  Remember the love you feel today.'
    },{
      'title': 'Thank you',
      'category': 'thank_you',
      'image': 'assets/images/img_thank.png',
      'color': const Color.fromRGBO(51, 158, 107, 0.5),
      'greetings': 'Thanks a lot!, Thank you very much!, I really appreciate it!, Sincerely thanks, How can I ever thank you?, You are so kind, I owe you a great deal'
    },{
      'title': 'Anniversary',
      'category': 'anniversary',
      'image': 'assets/images/img_anniversary.png',
      'color': const Color.fromRGBO(51, 113, 158, 0.5),
    },{
      'title': 'New baby',
      'category': 'new_baby',
      'image': 'assets/images/img_new_baby.png',
      'color': const Color.fromRGBO(156, 156, 156, 0.5),
    },{
      'title': 'New home',
      'category': 'new_home',
      'image': 'assets/images/img_new_home.png',
      'color': const Color.fromRGBO(31, 39, 56, 0.5),
    },{
      'title': 'Holidays',
      'category': 'holiday',
      'image': 'assets/images/img_hodidays.png',
      'color': const Color.fromRGBO(66, 134, 197, 0.5),
    },{
      'title': 'Love & Romance',
      'category': 'love_romance',
      'image': 'assets/images/img_love.png',
      'color': const Color.fromRGBO(255, 90, 110, 0.5),
    }
  ];
}