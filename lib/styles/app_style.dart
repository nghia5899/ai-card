import 'package:ai_ecard/styles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  AppStyles._();

  //fontSize
  static double largeSize = 16.w;
  static double xSmallSize = 10.w;
  static double smallSize = 12.w;
  static double mediumSize = 14.w;
  static double headerSize = 24.w;

  //fontWeight
  static FontWeight bold = FontWeight.w700;
  static FontWeight medium = FontWeight.w500;
  static FontWeight regular = FontWeight.w400;

  //fontStyle
  static TextStyle primaryButtonTitle =
      TextStyle(color: AppColors.primaryTextColor, fontSize: largeSize, fontWeight: bold);

  static TextStyle textButtonTitle = TextStyle(color: AppColors.primaryColor, fontSize: largeSize, fontWeight: bold);

  static TextStyle subTextButtonTitle =
      TextStyle(color: AppColors.primaryColor, fontSize: xSmallSize, fontWeight: medium);

  static TextStyle subTexTitle = TextStyle(color: AppColors.primaryColor, fontSize: mediumSize, fontWeight: regular);

  static TextStyle pageHeader = TextStyle(color: AppColors.primaryTextColor, fontSize: headerSize, fontWeight: bold);

  static TextStyle descriptionText = TextStyle(color: AppColors.primaryTextColor, fontSize: largeSize, fontWeight: medium);

  static TextStyle suggestText = TextStyle(color: AppColors.suggestTextColor, fontSize: largeSize, fontWeight: medium);

  static TextStyle descriptionIconText = TextStyle(color: AppColors.descriptionIconColor, fontSize: smallSize, fontWeight: regular);
}
