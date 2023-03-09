import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/widgets/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'helper/helper.dart';
import 'import.dart';

ThemeMode currentTheme = ThemeMode.light;

late FToast fToast;

final fToastBuilder = FToastBuilder();


showMessage(String msg,{String? type,int timeSlow = 3, Color? backgroundColor, Color? textColor, ToastGravity gravity = ToastGravity.TOP, double? fontSize}){
  String _type = !empty(type)?type!.toUpperCase():'';
  Color color;
  switch(_type){
    case 'SUCCESS':
      color = Colors.green;
      break;
    case 'FAIL':
      color = Colors.red;
      break;
    case 'ERROR':
      color = Colors.red;
      break;
    case 'WARNING':
      color = Colors.orangeAccent;
      break;
    default:
      color = Colors.blue;
  }

  Fluttertoast.showToast(
      timeInSecForIosWeb: timeSlow,
      fontSize: fontSize,
      backgroundColor: color,
      gravity: gravity,
      msg: msg
  );

}

onChangeTheme(String theme){
  switch(theme){
    case 'light':
      currentTheme = ThemeMode.light;
      break;
    case 'dark':
      currentTheme = ThemeMode.dark;
      break;
    default:
      currentTheme = ThemeMode.system;
  }
  Get.changeThemeMode(currentTheme);
}

void tapHandler(BuildContext context,{String? text,TextStyle? textStyle,TextAlign? textAlign, ValueChanged<TextInfo>? onChange}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(
      milliseconds: 400,
    ),
    pageBuilder: (_, __, ___) {
      return Container(
        color: Colors.black.withOpacity(0.4),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            // top: false,
            child: FormTextField(
              value: text,
              textAlign: textAlign,
              textStyle: textStyle,
              onPress: (obj){
                if(onChange != null){
                  onChange(obj);
                }
              },
            ),
          ),
        ),
      );
    },
  );
}