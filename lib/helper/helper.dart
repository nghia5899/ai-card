import '../import.dart';

empty(dynamic data){
  if(data == null){
    return true;
  }
  if(data is List && data.isEmpty) return true;
  if(data is Map && data.isEmpty) return true;
  if(data is String && data.isNotEmpty) return false;
  if(data.toString().isNotEmpty) return false;
  return true;
}


/// dùng để in ra tất cả dữ liệu
print_r(dynamic data){
  if(data is Map){
    data.forEach((key, value) {
      if (kDebugMode) {
        print('$key : $value');
      }
    });
  }else if(data is List){
    for(var val in data){
      if (kDebugMode) {
        print('${val.runtimeType} : $val');
      }
    }
  }else{
    if (kDebugMode) {
      print('${data.runtimeType}');
    }
  }
}