import 'dart:typed_data';

import 'package:ai_ecard/models/text_info.dart';
import 'package:image_size_getter/image_size_getter.dart';

class EditState {
  Uint8List image;
  List<TextInfo> textInfo;
  double imageWidth = 0;
  double imageHeight = 0;

  EditState(this.image, this.textInfo){
    final memoryImageSize = ImageSizeGetter.getSize(MemoryInput(image));
    imageWidth = memoryImageSize.width.toDouble();
    imageHeight = memoryImageSize.height.toDouble();
  }

}