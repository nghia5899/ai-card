import 'dart:typed_data';
import 'package:ai_ecard/helper/file_helper.dart';
import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/pages/home/detail/page.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/widgets/edit_text_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_editor/image_editor.dart';

enum EditTextType {
  none,
  font,
  color,
}

enum TextAlignEnum { left, center, right }

enum PageEnum { front, inside, back }

enum EditIconEnum { none, generateImage, crop, generateText, font, color, align }

class ExportController extends GetxController {
  RxList<EditObject> stack = <EditObject>[].obs;

  late Rx<Uint8List> image;

  late RxList<TextInfo> texts;

  // RxList<Uint8List> stackImage = <Uint8List>[].obs;
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();

  // RxList<TextInfo> text = [TextInfo(text: 'hello', positionLeft: 0, positionTop: 0)].obs;

  RxBool isEdit = false.obs;
  RxBool isEditText = false.obs;
  RxBool isMoveText = false.obs;
  RxBool fontIconSelected = false.obs;
  RxBool colorIconSelected = false.obs;

  RxInt stackIndex = 0.obs;
  Rx<EditTextType> editTextType = EditTextType.none.obs;

  List<String> fonts = const [
    'OpenSans',
    'Billabong',
    'GrandHotel',
    'Oswald',
    'Quicksand',
    'BeautifulPeople',
    'BeautyMountains',
    'BiteChocolate',
    'BlackberryJam',
    'BunchBlossoms',
    'CinderelaRegular',
    'Countryside',
    'Halimun',
    'LemonJelly',
    'QuiteMagicalRegular',
    'Tomatoes',
    'TropicalAsianDemoRegular',
    'VeganStyle',
  ];

  List<Color> colors = const [Colors.red, Colors.blue, Colors.green];

  Rx<TextAlignEnum> textAlign = TextAlignEnum.center.obs;
  Rx<PageEnum> pageEnum = PageEnum.front.obs;
  Rx<EditIconEnum> editIconSelected = EditIconEnum.none.obs;
  int textSelectedEdit = -1;

  @override
  void onInit() {
    super.onInit();
    stack.add(Get.arguments as EditObject);
    image = stack[0].image.obs;
    texts = stack[0].textInfo.obs;
  }

  Future<void> showToast(String text) async {
    Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_SHORT);
  }

  Future<void> saveImage(Widget image) async {
    Uint8List data = await FileHelper.createImage(image);
    await FileHelper.saveFileToGallery('test.png', 'AI-Ecard', data);
    showToast('Save successfully');
  }

  Future<void> shareImage(Widget image) async {
    Uint8List data = await FileHelper.createImage(image);
    await FileHelper.saveFileToGallery('test.png', 'AI-Ecard', data);
    await FileHelper.shareFile(files: ['test.png'], text: 'AI-Ecard', subject: 'AI-Ecard');
    showToast('Share successfully');
  }

  void onTapImage() {
    isEdit.value = !isEdit.value;
    isEditText.value = false;
  }

  void onTapText(int index) {
    textSelectedEdit = index;
    isEdit.value = !isEdit.value;
    isEditText.value = true;
    isMoveText.value = true;
  }

  void onDoubleTapText(int index) async {
    textSelectedEdit = index;
    isEdit.value = !isEdit.value;
    isEditText.value = true;
    isMoveText.value = false;

    Get.dialog(
      EditTextDialog(
        textInfo: texts.value[index],
        onChanged: (value) {
          updateText(value);
        },
        done: (value) {
          List<TextInfo> textInfo = [...stack[stackIndex.value].textInfo];
          EditObject editObject = EditObject(stack[stackIndex.value].image, textInfo);
          stack.add(editObject);
          stackIndex.value += 1;
          image.value = stack[stackIndex.value].image;
          texts.value = stack[stackIndex.value].textInfo;
        },
      ),
      barrierDismissible: false,
    );
  }

  void updateEditText(bool value) {
    isEditText.value = value;
  }

  void updateText(String value) {
    texts[textSelectedEdit].text = value;
    texts.refresh();
  }

  Future<void> crop() async {
    if (editorKey.currentState != null) {
      final Rect? cropRect = editorKey.currentState!.getCropRect();
      if (cropRect != null) {
        var data = editorKey.currentState!.rawImageData;
        ImageEditorOption option = ImageEditorOption();
        if (editorKey.currentState!.editAction != null) {
          if (editorKey.currentState!.editAction!.needCrop) {
            option.addOption(ClipOption.fromRect(cropRect));
            Uint8List? image = (await ImageEditor.editImage(
              image: data,
              imageEditorOption: option,
            ));
            if (image != null) {
              stack.add(EditObject(image, texts));
              stackIndex.value = stackIndex.value + 1;
              this.image.value = stack[stackIndex.value].image;
              onTapImage();
            }
          }
        }
      }
    }
  }

  void updatePosition(double y, double x) {
    texts.value[textSelectedEdit].positionTop = y;
    texts.value[textSelectedEdit].positionLeft = x;
    texts.refresh();
  }

  void undo() {
    if (stackIndex.value > 0) {
      stackIndex.value = stackIndex.value - 1;
      image.value = stack[stackIndex.value].image;
    }
  }

  void redo() {
    if (stackIndex.value <= stack.length - 1) {
      stackIndex.value = stackIndex.value + 1;
      image.value = stack[stackIndex.value].image;
    }
  }

  void colorSelectedIndex(int index) {
    texts.value[textSelectedEdit].color = colors[index];
    texts.refresh();
  }

  void fontSelectedIndex(int index) {
    texts.value[textSelectedEdit].fontFamily = fonts[index];
    texts.refresh();
  }

  void onTapGenerateImage() async {
    final a = await Get.toNamed(AppRoutes.generateImage);
    // editIconSelected.value = EditIconEnum.generateImage;
  }

  void onTapCropImage() {
    crop();
    // editIconSelected.value = EditIconEnum.crop;
  }

  void onTapGenerateText() async {
    String result = await Get.toNamed(AppRoutes.generateContent) as String;
    editIconSelected.value = EditIconEnum.generateText;
    updateText(result);
  }

  void onTapChangeFont() {
    editTextType.value = EditTextType.font;
    editIconSelected.value = EditIconEnum.font;
  }

  void onTapChangeColor() {
    editTextType.value = EditTextType.color;
    editIconSelected.value = EditIconEnum.color;
  }

  void onTapChangeAlign() {
    editIconSelected.value = EditIconEnum.align;
  }

  void onTapFront() async {
    pageEnum.value = PageEnum.front;
  }

  void onTapInside() async {
    pageEnum.value = PageEnum.inside;
  }

  void onTapBack() async {
    pageEnum.value = PageEnum.back;
  }

  void changeFontSize(double fontSize) {
    texts.value[textSelectedEdit] = texts.value[textSelectedEdit].copyWith(fontSize: fontSize);
    texts.refresh();
  }
}
