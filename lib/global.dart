import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/widgets/form_text_field.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'helper/helper.dart';
import 'import.dart';

ThemeMode currentTheme = ThemeMode.light;

final botToastBuilder = BotToastInit();

// const String apiKey = """eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImE2ZWFmN2M0LWEyZTktNDZlMC1hNGVlLTk2YTA2MmJiZDhmZCIsImV4cCI6MTY3OTM4NDM2Nn0.WfOi6HN5_RRNgLBwxaXItPC_xOsRrbz0B3rBwqULUj0""";
const String apiKey = """eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU2MTZhZjg3LTdlODQtNDI4NS05MWViLTg0YWFjZjJlOGEwZCIsImV4cCI6MTY3OTg4NTc1NX0.1Mp2ihzRu028njq_cFotOfBYj1BRBhNShX5pZqoJX74""";

showMessage(String msg,{String? type,int timeSlow = 3, Color? textColor}){
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

  BotToast.showNotification(
    backgroundColor: color,
    align: const Alignment(0, -0.99),
    duration: Duration(seconds: timeSlow),
    title: (cancelFunc) {
      return Text(
          msg,
        maxLines: 5,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: textColor??Colors.white),
      );
    },
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

InputDecoration inputDecoration({
  bool filled = true,
  String? labelText,
  String? hintText,
  String? errorText,
  TextStyle? textStyle,
  Color? fillColor,
  BoxConstraints? boxConstraints,
  EdgeInsets? contentPadding,
  Widget? suffixIcon,
  Widget? prefixIcon,
  bool enabled = true,
  bool borderNone = false
}){
  return InputDecoration(
    errorMaxLines: 2,
    filled: filled,
    labelText: labelText,
    hintText: hintText,
    fillColor: fillColor,
    contentPadding: contentPadding,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    enabled: enabled,
    prefixIconConstraints: boxConstraints,
    labelStyle: TextStyle(
      color: Theme.of(Get.context!).textTheme.bodyLarge!.color
    ),
    border: borderNone? InputBorder.none: OutlineInputBorder(
      borderRadius: borderRadius,
        borderSide: borderSide
    ),
    errorBorder: borderNone? InputBorder.none: OutlineInputBorder(
        borderRadius: borderRadius,
    ),
    enabledBorder:borderNone? InputBorder.none: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: borderSide
    ),
    focusedBorder:borderNone? InputBorder.none: OutlineInputBorder(
        borderRadius: borderRadius
    ),
    focusedErrorBorder:borderNone? InputBorder.none: OutlineInputBorder(
        borderRadius: borderRadius,
      borderSide: borderSide
    ),

  );
}

BorderRadius get borderRadius => const BorderRadius.all(Radius.circular(16));

BorderSide get borderSide => const BorderSide(width: 1);

Function showLoading = (){
  cusTomLoading();
  // BotToast.showLoading(
  //
  // );
};

Function disableLoading = (){
  BotToast.closeAllLoading();
};


Function cusTomLoading = (){
   BotToast.showCustomLoading(
       toastBuilder: (void Function() cancelFunc) {
         return LoadingAnimationWidget.threeRotatingDots(
             color:const Color(0xff94A3B8),
             size: 35
         );
       },
       crossPage: true
   );
};

