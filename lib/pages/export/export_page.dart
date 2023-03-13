import 'dart:typed_data';

import 'package:ai_ecard/helper/file_helper.dart';
import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/pages/export/export_controller.dart';
import 'package:ai_ecard/pages/image_editor/page.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_icon.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:ai_ecard/widgets/custom_text_button.dart';
import 'package:ai_ecard/widgets/draggable_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:ai_ecard/widgets/draggable_text.dart';
import 'package:ai_ecard/widgets/edit_icon.dart';
import 'package:ai_ecard/widgets/list_color.dart';
import 'package:ai_ecard/widgets/list_font.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as image;
import 'package:text_editor/text_editor.dart';

class ExportPage extends GetView<ExportController> {
  const ExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppScaffold(
        backGroundColor: AppColors.primaryBackGroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 56.w,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(AppIcons.iconClose, width: 24.w, height: 24.w),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  onTap: () {
                    controller.undo();
                  },
                  child: SvgPicture.asset(AppIcons.iconUndo, width: 24.w, height: 24.w),
                ),
                SizedBox(width: 12.w),
                GestureDetector(
                  child: SvgPicture.asset(AppIcons.iconRedo, width: 24.w, height: 24.w),
                ),
              ],
            ),
          ),
          leadingWidth: 144.w,
          actions: [
            Center(
              child: CustomTextButton(
                  title: 'save'.tr,
                  titleStyle: AppStyles.textButtonTitle.copyWith(fontSize: AppStyles.smallSize),
                  backgroundColor: AppColors.smallButtonColor,
                  height: 24.w,
                  width: 48.w,
                  borderRadius: 6.w,
                  onPressed: () {
                    controller.saveImage(
                        imagePainter(width: 327.w, image: controller.image.value, textInfo: controller.texts));
                  }),
            ),
            SizedBox(width: 24.w),
            GestureDetector(
              onTap: () {
                controller
                    .shareImage(imagePainter(width: 327.w, image: controller.image.value, textInfo: controller.texts));
              },
              child: SvgPicture.asset(AppIcons.iconUpload, width: 24.w, height: 24.w),
            ),
            SizedBox(width: 24.w)
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.w),
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ListView(
                  children: [
                    GestureDetector(
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.onTapImage();
                            },
                            child: Obx(() {
                              if (controller.isEdit.value && !controller.isEditText.value) {
                                return Container(
                                  alignment: Alignment.topCenter,
                                  constraints: BoxConstraints(minWidth: 327.w, minHeight: 0, maxHeight: 500.w),
                                  child: ExtendedImage.memory((controller.image.value),
                                      width: 327.w,
                                      matchTextDirection: true,
                                      fit: BoxFit.contain,
                                      mode: ExtendedImageMode.editor,
                                      extendedImageEditorKey: controller.editorKey,
                                      cacheRawData: true, initEditorConfigHandler: (state) {
                                    return EditorConfig(
                                        maxScale: 20.0,
                                        cornerSize: const Size(0, 0),
                                        lineColor: Colors.blueAccent,
                                        lineHeight: 1,
                                        hitTestSize: 20);
                                  }),
                                );
                              } else {
                                return Container(
                                  width: 327.w,
                                  alignment: Alignment.topCenter,
                                  child: Image(
                                    width: 327.w,
                                    fit: BoxFit.fitWidth,
                                    image: Image.memory(controller.image.value).image,
                                  ),
                                );
                              }
                            }),
                          ),
                          for (int i = 0; i < controller.texts.value.length; i++)
                            Obx(() {
                              if (controller.isEdit.value &&
                                  controller.isEditText.value &&
                                  controller.isMoveText.value &&
                                  controller.textSelectedEdit == i) {
                                return Obx(() => DraggableText(
                                      textInfo: controller.texts.value[i],
                                    ));
                              } else {
                                return Positioned(
                                  top: controller.texts.value[i].positionTop,
                                  left: controller.texts.value[i].positionLeft,
                                  child: GestureDetector(
                                    onDoubleTap: () {
                                      controller.onDoubleTapText(i);
                                    },
                                    onTap: () {
                                      controller.onTapText(i);
                                    },
                                    child: Text(
                                      controller.texts.value[i].text ?? '',
                                      style: TextStyle(
                                          color: controller.texts.value[i].color,
                                          fontSize: controller.texts.value[i].fontSize,
                                          fontFamily: controller.texts.value[i].fontFamily),
                                    ),
                                  ),
                                );
                              }
                            })
                        ],
                      ),
                    ),
                    // Image(image: Image.memory(data).image, width: 327.w, fit: BoxFit.fitWidth),
                    SizedBox(height: 120.w)
                  ],
                ),
              ),
              Obx(() => tabGroup(controller.isEdit.value, controller.isEditText.value))
            ],
          ),
        ),
      ),
    );
  }

  Widget tabGroup(bool isEdit, bool isEditText) {
    if (isEdit) {
      if (isEditText) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 158.w,
            width: double.infinity,
            child: Column(
              children: [
                Obx(
                  () => SizedBox(
                    height: 76.w,
                    child: controller.editTextType.value == EditTextType.font
                        ? ListFont(
                            fonts: controller.fonts,
                            onTapFont: controller.fontSelectedIndex,
                            selectedIndex: 0,
                            onSizeChange: controller.changeFontSize,
                            fontSize: 20,
                          )
                        : controller.editTextType.value == EditTextType.color
                            ? ListColor(
                                colors: controller.colors,
                                onTapColor: controller.colorSelectedIndex,
                                selectedIndex: 0,
                              )
                            : const SizedBox(),
                  ),
                ),
                SizedBox(height: 16.w),
                Container(
                  width: double.infinity,
                  height: 66.w,
                  decoration: BoxDecoration(
                      color: AppColors.primaryTextColor, borderRadius: BorderRadius.all(Radius.circular(16.w))),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: GestureDetector(
                            onTap: () async {
                              // controller.crop();
                            },
                            child: SvgPicture.asset('assets/icons/ic_arrow_left_square.svg', width: 24.w, height: 24.w),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 22.w),
                          Obx(() => EditIcon(
                                icon: SvgPicture.asset(
                                  'assets/icons/ic_generate.svg',
                                  width: 24.w,
                                  height: 24.w,
                                ),
                                isSelected: controller.editIconSelected.value == EditIconEnum.generateText,
                                title: 'generate'.tr,
                                onTap: controller.onTapGenerateImage,
                                selectTitleStyle:
                                    AppStyles.descriptionIconText.copyWith(color: const Color(0xFF1B514A)),
                              )),
                          SizedBox(width: 22.w),
                          Obx(
                            () => EditIcon(
                              icon: SvgPicture.asset(
                                'assets/icons/ic_font.svg',
                                width: 24.w,
                                height: 24.w,
                              ),
                              selectedIcon: SvgPicture.asset(
                                'assets/icons/ic_dot.svg',
                                width: 4.w,
                                height: 4.w,
                              ),
                              isSelected: controller.editIconSelected.value == EditIconEnum.font,
                              title: 'Font',
                              onTap: controller.onTapChangeFont,
                              selectTitleStyle: AppStyles.descriptionIconText.copyWith(color: const Color(0xFF1B514A)),
                            ),
                          ),
                          SizedBox(width: 22.w),
                          Obx(
                            () => EditIcon(
                              icon: SvgPicture.asset(
                                'assets/icons/ic_color.svg',
                                width: 24.w,
                                height: 24.w,
                              ),
                              selectedIcon: SvgPicture.asset(
                                'assets/icons/ic_dot.svg',
                                width: 4.w,
                                height: 4.w,
                              ),
                              isSelected: controller.editIconSelected.value == EditIconEnum.color,
                              title: 'Color',
                              onTap: controller.onTapChangeColor,
                              selectTitleStyle: AppStyles.descriptionIconText.copyWith(color: const Color(0xFF1B514A)),
                            ),
                          ),
                          SizedBox(width: 22.w),
                          Obx(
                            () => EditIcon(
                              icon: SvgPicture.asset(
                                'assets/icons/ic_text_align_center.svg',
                                width: 24.w,
                                height: 24.w,
                              ),
                              isSelected: controller.editIconSelected.value == EditIconEnum.align,
                              title: 'Center',
                              onTap: controller.onTapChangeAlign,
                              selectTitleStyle: AppStyles.descriptionIconText.copyWith(color: const Color(0xFF1B514A)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 66.w,
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryTextColor, borderRadius: BorderRadius.all(Radius.circular(16.w))),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 18.w),
                      child: GestureDetector(
                        onTap: () async {
                          // controller.crop();
                        },
                        child: SvgPicture.asset('assets/icons/ic_arrow_left_square.svg', width: 24.w, height: 24.w),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => EditIcon(
                            icon: SvgPicture.asset(
                              'assets/icons/ic_generate.svg',
                              width: 24.w,
                              height: 24.w,
                            ),
                            isSelected: controller.editIconSelected.value == EditIconEnum.generateImage,
                            title: 'generate'.tr,
                            onTap: controller.onTapGenerateImage,
                            selectTitleStyle: AppStyles.descriptionIconText.copyWith(color: const Color(0xFF1B514A)),
                          )),
                      SizedBox(width: 32.w),
                      Obx(() => EditIcon(
                            icon: SvgPicture.asset('assets/icons/ic_crop.svg', width: 24.w, height: 24.w),
                            isSelected: controller.editIconSelected.value == EditIconEnum.crop,
                            title: 'Crop',
                            onTap: controller.onTapCropImage,
                            selectTitleStyle: AppStyles.descriptionIconText.copyWith(color: const Color(0xFF1B514A)),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } else {
      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SizedBox(
          height: 66.w,
          width: double.infinity,
          child: Container(
            decoration:
                BoxDecoration(color: AppColors.primaryTextColor, borderRadius: BorderRadius.all(Radius.circular(16.w))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => EditIcon(
                      icon: SvgPicture.asset(
                        'assets/icons/ic_front.svg',
                        width: 24.w,
                        height: 24.w,
                        color: Color(0xFF64748B),
                      ),
                      selectedIcon: SvgPicture.asset(
                        'assets/icons/ic_dot.svg',
                        width: 4.w,
                        height: 4.w,
                      ),
                      isSelected: controller.pageEnum.value == PageEnum.front,
                      title: 'Front',
                      onTap: controller.onTapFront,
                      selectTitleStyle: AppStyles.descriptionIconText.copyWith(color: const Color(0xFF1B514A)),
                    )),
                SizedBox(width: 32.w),
                Obx(() => EditIcon(
                      icon: SvgPicture.asset(
                        'assets/icons/ic_inside.svg',
                        width: 24.w,
                        height: 24.w,
                        color: const Color(0xFF64748B),
                      ),
                      selectedIcon: SvgPicture.asset(
                        'assets/icons/ic_dot.svg',
                        width: 4.w,
                        height: 4.w,
                      ),
                      isSelected: controller.pageEnum.value == PageEnum.inside,
                      title: 'Inside',
                      onTap: controller.onTapInside,
                      selectTitleStyle: AppStyles.descriptionIconText.copyWith(color: const Color(0xFF1B514A)),
                    )),
                SizedBox(width: 32.w),
                Obx(() => EditIcon(
                      icon: SvgPicture.asset(
                        'assets/icons/ic_back.svg',
                        width: 24.w,
                        height: 24.w,
                        color: const Color(0xFF64748B),
                      ),
                      selectedIcon: SvgPicture.asset(
                        'assets/icons/ic_dot.svg',
                        width: 4.w,
                        height: 4.w,
                      ),
                      isSelected: controller.pageEnum.value == PageEnum.back,
                      title: 'Crop',
                      onTap: controller.onTapBack,
                      selectTitleStyle: AppStyles.descriptionIconText.copyWith(color: const Color(0xFF1B514A)),
                    )),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget imagePainter({required double width, required Uint8List image, required List<TextInfo> textInfo}) {
    return Stack(children: [
      Container(
        width: width,
        alignment: Alignment.topCenter,
        child: Image(
          image: Image.memory(image).image,
          width: width,
          fit: BoxFit.fitWidth,
        ),
      ),
      for (int i = 0; i < textInfo.length; i++)
        Positioned(
          top: textInfo[i].positionTop,
          left: textInfo[i].positionLeft,
          child: Text(
            textInfo[i].text ?? '',
            style:
                TextStyle(color: textInfo[i].color, fontSize: textInfo[i].fontSize, fontFamily: textInfo[i].fontFamily),
          ),
        ),
    ]);
  }
}
