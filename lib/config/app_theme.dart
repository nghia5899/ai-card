import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black12,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white
    )
  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xff1B514A),

  );

  static get getTheme{

  }

}