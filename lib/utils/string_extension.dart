import 'package:intl/intl.dart';

extension ExString on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

}

extension StringBase on String{
  String date([String? format]){
    final String type = format ?? 'dd/MM/yyy';
    if(isNotEmpty || this is num){
      return DateFormat(type).format(toString().toDateTime());
    }
    return '';
  }

  DateTime toDateTime(){
    RegExp regExpNum = RegExp(r"^\s*\d*\s*$",multiLine: true,caseSensitive: false);
    if(regExpNum.hasMatch(toString()) == true){
      return DateTime.fromMicrosecondsSinceEpoch(int.parse(this) * 1000);
    }
    return DateTime.now();
  }
}