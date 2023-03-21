import 'dart:typed_data';
import 'package:ai_ecard/global.dart';
import 'package:ai_ecard/helper/file_helper.dart';
import 'package:ai_ecard/models/edit/edit_model.dart';
import 'package:ai_ecard/models/edit/edit_state.dart';
import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/pages/edit/edit_controller.dart';
import 'package:ai_ecard/pages/export/export_page.dart';
import 'package:ai_ecard/widgets/animation_fold_card.dart';
import 'package:ai_ecard/widgets/export_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ExportController extends GetxController {
  final foldingCardKey = const GlobalObjectKey<FoldingCardState>('exportFoldingCard');
  late Rx<EditModel> front;
  late RxList<EditModel> inside = <EditModel>[].obs;
  late Rx<EditModel> backside;

  RxInt sliderIndex = 0.obs;

  double frontCardWidth = 1;
  double frontCardHeight = 1;

  Rx<TextAlignEnum> textAlign = TextAlignEnum.center.obs;
  Rx<PageEnum> pageEnum = PageEnum.front.obs;

  Rx<bool> isAnimationFoldRunning = false.obs;

  @override
  void onInit() {
    super.onInit();
    ExportModel firstState = Get.arguments as ExportModel;
    frontCardWidth = firstState.front.imageWidth;
    frontCardHeight = firstState.front.imageHeight;
    front = EditModel(image: firstState.front.image, texts: firstState.front.textInfo).obs;
    front.refresh();
    inside.add(EditModel(image: firstState.inside[0].image, texts: firstState.inside[0].textInfo));
    inside.add(EditModel(image: firstState.inside[1].image, texts: firstState.inside[1].textInfo));
  }

  Future<void> showToast(String text) async {
    Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_SHORT);
  }

  Future<void> saveFile() async {
    Get.bottomSheet(
      ExportBottomSheet(
        title: 'Save',
        onTapImage: () {
          saveImage();
          Get.back();
        },
        onTapPdf: () {
          savePDF();
          Get.back();
        },
      ),
    );
  }

  Future<void> shareFile() async {
    Get.bottomSheet(ExportBottomSheet(
      title: 'Share',
      onTapImage: () {
        shareImage();
        Get.back();
      },
      onTapPdf: () {
        sharePDF();
        Get.back();
      },
    ));
  }

  Future<void> saveImage() async {
    double width = Get.width - 24.w;
    double height = width * frontCardHeight / frontCardWidth;

    try {
      showLoading();
      Uint8List imageFront = await FileHelper.createImage(
          imagePainter(width: width, height: height, image: front.value.image, textInfo: front.value.texts));
      Uint8List imageInsideFront = await FileHelper.createImage(
          imagePainter(width: width, height: height, image: inside.value[0].image, textInfo: inside.value[0].texts));
      Uint8List imageInsideBack = await FileHelper.createImage(
          imagePainter(width: width, height: height, image: inside.value[1].image, textInfo: inside.value[1].texts));
      Uint8List imageBackSide = await FileHelper.createImage(
          imagePainter(width: width, height: height, image: front.value.image, textInfo: front.value.texts));

      String fileName = "ai-ecard-${this.fileName}";
      String fileNameFront = "${fileName}-1.png";
      String fileNameInsideFront = "${fileName}-2.png";
      String fileNameInsideBack = "${fileName}-3.png";
      String fileNameBackside = "${fileName}-4.png";

      await FileHelper.saveFileToGallery(fileNameFront, 'AI-Ecard', imageFront);
      await FileHelper.saveFileToGallery(fileNameInsideFront, 'AI-Ecard', imageInsideFront);
      await FileHelper.saveFileToGallery(fileNameInsideBack, 'AI-Ecard', imageInsideBack);
      await FileHelper.saveFileToGallery(fileNameBackside, 'AI-Ecard', imageBackSide);

      disableLoading();
      showMessage('Save successfully', type: 'SUCCESS');
    } catch (e) {
      disableLoading();
      showMessage('Save file failed', type: 'ERROR');
    }
  }

  Future<void> savePDF() async {
    double width = Get.width - 24.w;
    double height = width * frontCardHeight / frontCardWidth;

    try {
      showLoading();
      Uint8List data = await FileHelper.createPDF([
        imagePainter(width: width, height: height, image: front.value.image, textInfo: front.value.texts),
        imagePainter(width: width, height: height, image: inside.value[0].image, textInfo: inside.value[0].texts),
        imagePainter(width: width, height: height, image: inside.value[0].image, textInfo: inside.value[1].texts),
        imagePainter(width: width, height: height, image: front.value.image, textInfo: []),
      ]);

      String fileName = "ai-ecard-${this.fileName}.pdf";
      await FileHelper.saveFileToStorage(fileName, data);
      disableLoading();
      showMessage('Save successfully', type: 'SUCCESS');
    } catch (e) {
      disableLoading();
      showMessage('Save file failed', type: 'ERROR');
    }
  }

  Future<void> shareImage() async {
    double width = Get.width - 24.w;
    double height = width * frontCardHeight / frontCardWidth;

    try {
      showLoading();
      Uint8List imageFront = await FileHelper.createImage(
          imagePainter(width: width, height: height, image: front.value.image, textInfo: front.value.texts));
      Uint8List imageInsideFront = await FileHelper.createImage(
          imagePainter(width: width, height: height, image: inside.value[0].image, textInfo: inside.value[0].texts));
      Uint8List imageInsideBack = await FileHelper.createImage(
          imagePainter(width: width, height: height, image: inside.value[1].image, textInfo: inside.value[1].texts));
      Uint8List imageBackSide = await FileHelper.createImage(
          imagePainter(width: width, height: height, image: front.value.image, textInfo: []));

      String fileName = "ai-ecard-${this.fileName}";
      String fileNameFront = "${fileName}-1.png";
      String fileNameInsideFront = "${fileName}-2.png";
      String fileNameInsideBack = "${fileName}-3.png";
      String fileNameBackside = "${fileName}-4.png";

      await FileHelper.saveFileToGallery(fileNameFront, 'AI-Ecard', imageFront);
      await FileHelper.saveFileToGallery(fileNameInsideFront, 'AI-Ecard', imageInsideFront);
      await FileHelper.saveFileToGallery(fileNameInsideBack, 'AI-Ecard', imageInsideBack);
      await FileHelper.saveFileToGallery(fileNameBackside, 'AI-Ecard', imageBackSide);

      disableLoading();
      await FileHelper.shareFile(
          files: [fileNameFront, fileNameInsideFront, fileNameInsideBack, fileNameBackside],
          text: 'AI-Ecard',
          subject: 'AI-Ecard');
      showMessage('Save successfully', type: 'SUCCESS');
    } catch (e) {
      disableLoading();
      showMessage('Save file failed', type: 'ERROR');
    }
  }

  Future<void> sharePDF() async {
    double width = Get.width - 24.w;
    double height = width * frontCardHeight / frontCardWidth;

    try {
      showLoading();
      Uint8List data = await FileHelper.createPDF([
        imagePainter(width: width, height: height, image: front.value.image, textInfo: front.value.texts),
        imagePainter(width: width, height: height, image: inside.value[0].image, textInfo: inside.value[0].texts),
        imagePainter(width: width, height: height, image: inside.value[1].image, textInfo: inside.value[1].texts),
        imagePainter(width: width, height: height, image: front.value.image, textInfo: []),
      ]);

      String fileName = "ai-ecard-${this.fileName}.pdf";
      await FileHelper.saveFileToStorage(fileName, data);

      disableLoading();
      await FileHelper.shareFile(files: [fileName], text: 'AI-Ecard', subject: 'AI-Ecard');
      showMessage('Save successfully', type: 'SUCCESS');
    } catch (e) {
      disableLoading();
      showMessage('Save file failed', type: 'ERROR');
    }
  }

  void onTapFront() async {
    if (pageEnum.value != PageEnum.front) {
      pageEnum.value = PageEnum.front;
      isAnimationFoldRunning.value = true;
      Future.delayed(const Duration(milliseconds: 50)).then((value) {
        foldingCardKey.currentState?.toggleFold();
      });
    }
  }

  void onTapInside() async {
    if (pageEnum.value != PageEnum.inside) {
      sliderIndex.value = 1;
      pageEnum.value = PageEnum.inside;
      isAnimationFoldRunning.value = true;
      Future.delayed(const Duration(milliseconds: 50)).then((value) {
        foldingCardKey.currentState?.toggleFold();
      });
    }
  }

  void onTapBack() async {
    pageEnum.value = PageEnum.back;
  }

  void updateSliderImage(int index){
    sliderIndex.value = index;
  }

  Future<void> initBacksideCard() async {
    final ByteData bytes = await rootBundle.load("assets/images/template/img_t1.png");
    final Uint8List imageValue = bytes.buffer.asUint8List();
    backside = EditModel(image: imageValue, texts: []).obs;
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

  Rx<bool> get redoEnabled => (pageEnum.value == PageEnum.front)
      ? front.value.redoEnabled.obs
      : (pageEnum.value == PageEnum.inside)
          ? inside.value[sliderIndex.value].redoEnabled.obs
          : backside.value.redoEnabled.obs;

  String get fileName => DateTime.now().millisecondsSinceEpoch.toString();
}

class ExportModel {
  EditState front;
  List<EditState> inside;

  ExportModel(this.front, this.inside);
}
