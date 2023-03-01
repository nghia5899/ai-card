import 'package:ai_ecard/import.dart';

class DeviceType{
  DeviceType._();

  final double size = Get.width;

  static const DeviceSize phone = DeviceSize(null,480);
  static const DeviceSize tablet = DeviceSize(481,1367);
  static const DeviceSize desktop = DeviceSize(1367,null);


  DeviceSize? operator [](String size){
    if(size.contains('-')){
      final List _size = size.split('-');
      return DeviceSize(double.parse(_size[0]),double.parse(_size[1]));
    }
    return null;
  }

  static DeviceSize getSize([String? size]){
    switch(size){
      case 'phone':
        return DeviceType.phone;
      case 'tablet':
        return DeviceType.tablet;
      case 'desktop':
        return DeviceType.desktop;
      default:
        return DeviceType.phone;
    }
  }


}

class DeviceSize{
  final double? minWidth;
  final double? maxWidth;

  const DeviceSize([this.minWidth, this.maxWidth]);
}