import 'dart:typed_data';

import 'package:ai_ecard/models/text_info.dart';

class EditState {
  Uint8List image;
  List<TextInfo> textInfo;

  EditState(this.image, this.textInfo);
}