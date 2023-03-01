import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static void addLanguageCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', code);
  }

  static Future<String> getLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'vi';
  }

  // static void setThemeMode(AppTheme theme) async {
  //   var prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('themeMode', AppTheme.values.indexOf(theme));
  // }
  //
  // static Future<ThemeData> getThemeMode() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   int preferredTheme = prefs.getInt('themeMode') ?? 0;
  //   ThemeData _themeData = appThemeData[AppTheme.values[preferredTheme]]!;
  //   return _themeData;
  // }

  static Future<Map> getLanguages() async {
    var prefs = await SharedPreferences.getInstance();
    String languages = prefs.getString('languages') ?? '';
    Map<String, String> map = Map.castFrom(json.decode(languages));
    return map;
  }

  static Future setLanguages(Map languages) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languages', jsonEncode(languages));
  }

  static Future setUser(Map user) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user));
  }

  static removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  static Future setAskingForUpdate(bool isOpen) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAskingForUpdate', isOpen);
  }

  static Future<bool> getAskingForUpdate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool('isAskingForUpdate') ?? true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  static Future<bool> getFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('FirstTime') ?? true;
  }

  static Future setFirstTime() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('FirstTime', false);
  }

  static Future<bool?> getCheckAlreadyPassWord() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool('AlreadyPassWord');
  }

  static Future setCheckAlreadyPassWord(bool status) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('AlreadyPassWord', status);
  }

  static Future setHDWalletCreationIndex() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('hd-wallet-status-index', 2);
  }
}
