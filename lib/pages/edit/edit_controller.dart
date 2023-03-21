import 'dart:typed_data';
import 'package:ai_ecard/global.dart';
import 'package:ai_ecard/models/edit/edit_model.dart';
import 'package:ai_ecard/models/edit/edit_state.dart';
import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/pages/export/export_controller.dart';
import 'package:ai_ecard/pages/home/detail/page.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/animation_fold_card.dart';
import 'package:ai_ecard/widgets/edit_image.dart';
import 'package:ai_ecard/widgets/edit_text_dialog.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_editor/image_editor.dart';

enum EditTextType { none, font, color, align, size }

enum TextAlignEnum { left, center, right }

enum PageEnum { front, inside, back }

enum EditIconEnum { none, generateImage, crop, generateText, font, color, align, size }

class EditController extends GetxController {
  final foldingCardKey = const GlobalObjectKey<FoldingCardState>('editFolding');
  late Rx<EditModel> front;
  late RxList<EditModel> inside = <EditModel>[].obs;
  late Rx<EditModel> backside;

  RxInt sliderIndex = 0.obs;

  RxBool isInit = true.obs;
  RxBool isEdit = false.obs;
  RxBool isEditText = false.obs;
  RxBool isMoveText = false.obs;
  RxBool fontIconSelected = false.obs;
  RxBool colorIconSelected = false.obs;

  double frontCardWidth = 1;
  double frontCardHeight = 1;

  Rx<EditTextType> editTextType = EditTextType.none.obs;
  late CardObject firstState;

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

  List<Color> colors = const [
    Color(0xFFE85F59),
    Color(0xFFEFA543),
    Color(0xFFF5C3CB),
    Color(0xFFF7DC8B),
    Color(0xFF73CF9A),
    Color(0xFF9FCBF6),
    Color(0xFF3571E3),
    Color(0xFF8080EA),
    Color(0xFF1F262C),
    Color(0xFFBDC8D2),
    Color(0xFFFFFFFF)
  ];

  Rx<TextAlignEnum> textAlign = TextAlignEnum.center.obs;
  Rx<PageEnum> pageEnum = PageEnum.front.obs;
  Rx<EditIconEnum> editIconSelected = EditIconEnum.none.obs;
  Rx<int> textSelectedEdit = (-1).obs;

  Rx<bool> isAnimationFoldRunning = false.obs;

  @override
  void onInit() {
    super.onInit();
    firstState = Get.arguments as CardObject;
    front = EditModel(image: Uint8List(0), texts: firstState.textInfo).obs;
    showMessage('Tap on Text to edit text');
    initFrontCard(firstState.templateModel.image ?? '', firstState.textInfo);
    front.refresh();
  }

  Future<void> showToast(String text) async {
    Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_SHORT);
  }

  void editDone() {
    isEdit.value = false;
    addTextToStack();
  }

  void onTapImage() {
    isEdit.value = true;
    isEditText.value = false;
  }

  void onTapText(int index) {
    isEdit.value = true;
    onTapChangeFont();
    textSelectedEdit.value = index;
    isEditText.value = true;
    isMoveText.value = true;
  }

  void onDoubleTapText(int index) async {
    textSelectedEdit.value = index;
    isEdit.value = true;
    isEditText.value = true;
    isMoveText.value = true;

    Get.dialog(
      EditTextDialog(
        textInfo: texts.value[index],
        onChanged: (value) {
          updateText(value);
        },
        // done: (value) {
        //   List<TextInfo> textInfo = [...stack[stackIndex.value].textInfo];
        //   EditObject editObject = EditObject(stack[stackIndex.value].image, textInfo);
        //   stack.add(editObject);
        //   stackIndex.value += 1;
        //   image.value = stack[stackIndex.value].image;
        //   texts.value = stack[stackIndex.value].textInfo;
        // },
      ),
      barrierDismissible: false,
    );
  }

  void updateEditText(bool value) {
    isEditText.value = value;
  }

  void updateText(String value) {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          front.value.updateText(value, textSelectedEdit.value);
          front.refresh();
          break;
        }
      case PageEnum.inside:
        {
          inside.value[1].updateText(value, textSelectedEdit.value);
          inside.refresh();
          break;
        }
      case PageEnum.back:
        {
          backside.value.updateText(value, textSelectedEdit.value);
          backside.refresh();
          break;
        }
    }
  }

  void updateImage(Uint8List image) {
    inside.value[0].updateImage(image);
    inside.value[0].addToStack();
    inside.refresh();
  }

  void updatePosition(double y, double x) {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          front.value.updatePosition(y, x, textSelectedEdit.value);
          front.refresh();
          break;
        }
      case PageEnum.inside:
        {
          inside.value[1].updatePosition(y, x, textSelectedEdit.value);
          inside.refresh();
          break;
        }
      case PageEnum.back:
        {
          backside.value.updatePosition(y, x, textSelectedEdit.value);
          backside.refresh();
          break;
        }
    }
  }

  void updateSliderImage(int index){
    sliderIndex.value = index;
    isEdit.value = false;
  }

  void undo() {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          front.value.undo();
          front.refresh();
          break;
        }
      case PageEnum.inside:
        {
          inside.value[sliderIndex.value].undo();
          inside.refresh();
          break;
        }
      case PageEnum.back:
        {
          backside.value.undo();
          backside.refresh();
          break;
        }
    }
  }

  void redo() {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          front.value.redo();
          front.refresh();
          break;
        }
      case PageEnum.inside:
        {
          inside.value[sliderIndex.value].redo();
          inside.refresh();
          break;
        }
      case PageEnum.back:
        {
          backside.value.redo();
          backside.refresh();
          break;
        }
    }
  }

  void addTextToStack() {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          if (front.value.isNewState()) {
            front.value.addToStack();
            front.refresh();
          }
          break;
        }
      case PageEnum.inside:
        {
          if (inside.value[1].isNewState()) {
            inside.value[1].addToStack();
            inside.refresh();
          }
          break;
        }
      case PageEnum.back:
        {
          if (backside.value.isNewState()) {
            backside.value.addToStack();
            backside.refresh();
          }
          break;
        }
    }
  }

  void colorSelectedIndex(int index) {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          front.value.updateColor(colors[index], textSelectedEdit.value);
          front.refresh();
          break;
        }
      case PageEnum.inside:
        {
          inside.value[1].updateColor(colors[index], textSelectedEdit.value);
          inside.refresh();
          break;
        }
      case PageEnum.back:
        {
          backside.value.updateColor(colors[index], textSelectedEdit.value);
          backside.refresh();
          break;
        }
    }
  }

  void fontSelectedIndex(int index) {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          front.value.updateFontFamily(fonts[index], textSelectedEdit.value);
          front.refresh();
          break;
        }
      case PageEnum.inside:
        {
          inside.value[1].updateFontFamily(fonts[index], textSelectedEdit.value);
          inside.refresh();
          break;
        }
      case PageEnum.back:
        {
          backside.value.updateFontFamily(fonts[index], textSelectedEdit.value);
          backside.refresh();
          break;
        }
    }
  }

  void onTapGenerateImage() async {
    Get.toNamed(AppRoutes.generateImage);
  }

  void onTapCropImage() {
    // crop();
    Get.dialog(
        EditImage(
          image: inside.value[0].image,
          cropAspectRatio: frontCardWidth / frontCardHeight,
          onCrop: (image) {
            updateImage(image);
          }),
    );
  }

  void onTapGenerateText() async {
    editIconSelected.value = EditIconEnum.generateText;
    String? result = await Get.toNamed(AppRoutes.generateContent) as String?;
    if (result != null && result.isNotEmpty) {
      updateText(result);
    }
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
    editTextType.value = EditTextType.align;
  }

  void onTapChangeSize() {
    editIconSelected.value = EditIconEnum.size;
    editTextType.value = EditTextType.size;
  }

  void onTapFront() async {
    if (pageEnum.value != PageEnum.front) {
      textSelectedEdit.value = 0;
      pageEnum.value = PageEnum.front;
      isAnimationFoldRunning.value = true;
      Future.delayed(const Duration(milliseconds: 50)).then((value) {
        foldingCardKey.currentState?.toggleFold();
      });
    }
  }

  void onTapInside() async {
    if (pageEnum.value != PageEnum.inside) {
      textSelectedEdit.value = 0;
      sliderIndex.value = 1;
      pageEnum.value = PageEnum.inside;
      isAnimationFoldRunning.value = true;
      Future.delayed(const Duration(milliseconds: 50)).then((value) {
        foldingCardKey.currentState?.toggleFold();
      });
    }
  }

  void onTapBack() async {
    textSelectedEdit.value = 0;
    pageEnum.value = PageEnum.back;
  }

  void changeFontSize(double fontSize) {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          front.value.updateFontSize(fontSize, textSelectedEdit.value);
          front.refresh();
          break;
        }
      case PageEnum.inside:
        {
          inside.value[1].updateFontSize(fontSize, textSelectedEdit.value);
          inside.refresh();
          break;
        }
      case PageEnum.back:
        {
          backside.value.updateFontSize(fontSize, textSelectedEdit.value);
          backside.refresh();
          break;
        }
    }
  }

  void updateAlign(TextAlign textAlign) {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          front.value.updateAlign(textAlign, textSelectedEdit.value);
          front.refresh();
          break;
        }
      case PageEnum.inside:
        {
          inside.value[1].updateAlign(textAlign, textSelectedEdit.value);
          inside.refresh();
          break;
        }
      case PageEnum.back:
        {
          backside.value.updateAlign(textAlign, textSelectedEdit.value);
          backside.refresh();
          break;
        }
    }
  }

  Future<void> initFrontCard(String assets, List<TextInfo> textInfo) async {
    final ByteData bytes1 = await rootBundle.load(assets);
    final Uint8List imageValue = bytes1.buffer.asUint8List();
    EditState editState = EditState(imageValue, textInfo);
    frontCardWidth = editState.imageWidth;
    frontCardHeight = editState.imageHeight;
    front.value.updateImage(imageValue);
    front.value.addToStack();
    front.refresh();
    isInit.value = false;
    initInsideCard();
  }

  Future<void> initInsideCard() async {
    final ByteData bytes1 = await rootBundle.load("assets/images/template/inside/img_t0.png");
    final Uint8List imageValue = bytes1.buffer.asUint8List();
    inside.add(EditModel(image: imageValue, texts: []));

    List<TextInfo> clone = [];
    TextInfo textInfo = TextInfo(text: 'Tap text to generate text', fontSize: AppStyles.mediumSize, positionLeft: 90.w, positionTop: 222.w);
    clone.add(textInfo);
    inside.add(EditModel(image: Uint8List.fromList([...imageValue.toList()]), texts: clone));
  }

  RxList<TextInfo> get texts => (pageEnum.value == PageEnum.front)
      ? front.value.texts.obs
      : (pageEnum.value == PageEnum.inside)
          ? inside.value[1].texts.obs
          : backside.value.texts.obs;

  Rx<Uint8List> get image => (pageEnum.value == PageEnum.front)
      ? front.value.image.obs
      : (pageEnum.value == PageEnum.inside)
          ? inside.value[0].image.obs
          : backside.value.image.obs;

  Rx<bool> get undoEnabled => (pageEnum.value == PageEnum.front)
      ? front.value.undoEnabled.obs
      : (pageEnum.value == PageEnum.inside)
          ? inside.value[sliderIndex.value].undoEnabled.obs
          : backside.value.undoEnabled.obs;

  Rx<TextAlign?> get textAlignIndex => (pageEnum.value == PageEnum.front)
      ? front.value.textAlign(textSelectedEdit.value).obs
      : (pageEnum.value == PageEnum.inside)
          ? inside.value[1].textAlign(textSelectedEdit.value).obs
          : backside.value.textAlign(textSelectedEdit.value).obs;

  Rx<bool> get redoEnabled => (pageEnum.value == PageEnum.front)
      ? front.value.redoEnabled.obs
      : (pageEnum.value == PageEnum.inside)
          ? inside.value[sliderIndex.value].redoEnabled.obs
          : backside.value.redoEnabled.obs;

  Rx<bool> get isEditImage => (isEdit.value && !isEditText.value && pageEnum.value == PageEnum.inside && sliderIndex.value == 0).obs;

  void resetState() {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          if (front.value.isNewState()) {
            front.value.resetState();
            front.refresh();
          }
          break;
        }
      case PageEnum.inside:
        {
          if (inside.value[sliderIndex.value].isNewState()) {
            inside.value[sliderIndex.value].resetState();
            inside.refresh();
          }
          break;
        }
      case PageEnum.back:
        {
          if (backside.value.isNewState()) {
            backside.value.resetState();
            backside.refresh();
          }
          break;
        }
    }
    isEdit.value = false;
  }

  String get fileName => DateTime.now().millisecondsSinceEpoch.toString();

  TextAlign? textAlignValue() {
    switch (pageEnum.value) {
      case PageEnum.front:
        {
          return front.value.texts[textSelectedEdit.value].textAlign;
        }
      case PageEnum.inside:
        {
          return inside.value[sliderIndex.value].texts[textSelectedEdit.value].textAlign;
        }
      case PageEnum.back:
        {
          return backside.value.texts[textSelectedEdit.value].textAlign;
        }
    }
  }

  void toExportPage() {
    Get.toNamed(AppRoutes.export,
        arguments: ExportModel(front.value.stack[front.value.stackIndex],
            [inside.value[0].stack[inside.value[0].stackIndex], inside.value[1].stack[inside.value[1].stackIndex]]));
  }
}
