import 'dart:math';

import 'package:ai_ecard/pages/edit/edit_controller.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/edit_icon.dart';
import 'package:ai_ecard/widgets/list_align.dart';
import 'package:ai_ecard/widgets/list_color.dart';
import 'package:ai_ecard/widgets/list_font.dart';
import 'package:ai_ecard/widgets/slider_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TabGroup extends GetView<EditController> {
  final bool isEdit;
  final bool isEditText;

  const TabGroup({Key? key, required this.isEdit, required this.isEditText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isEdit) {
      if (isEditText) {
        return SizedBox(
          height: 160.w,
          width: double.infinity,
          child: Column(
            children: [
              Spacer(),
              Obx(
                () {
                  switch (controller.editTextType.value) {
                    case EditTextType.font:
                      {
                        return SizedBox(
                          height: 36.w,
                          child: ListFont(
                            fonts: controller.fonts,
                            onTapFont: controller.fontSelectedIndex,
                            selectedIndex: 0,
                          ),
                        );
                      }
                    case EditTextType.color:
                      {
                        return SizedBox(
                          height: 76.w,
                          child: ListColor(
                            colors: controller.colors,
                            onTapColor: controller.colorSelectedIndex,
                            selectedIndex: 0,
                          ),
                        );
                      }
                    case EditTextType.align:
                      {
                        return SizedBox(
                          height: 76.w,
                          child: ListAlign(
                            onTapAlign: (textAlign) {
                              controller.updateAlign(textAlign);
                            },
                            selected: controller.textAlignValue() ?? TextAlign.left,
                          ),
                        );
                      }
                    case EditTextType.size:
                      {
                        return SizedBox(
                          height: 76.w,
                          child: SliderSize(
                            fontSize: controller.texts[controller.textSelectedEdit.value].fontSize,
                            onSizeChange: (size) {
                              controller.changeFontSize(size);
                            },
                          ),
                        );
                      }
                    default:
                      {
                        return SizedBox();
                      }
                  }
                },
              ),
              SizedBox(height: 16.w),
              Container(
                width: double.infinity,
                height: 66.w,
                decoration: BoxDecoration(
                    color: AppColors.primaryTextColor, borderRadius: BorderRadius.all(Radius.circular(16.w))),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 22.w),
                    Obx(
                      () => EditIcon(
                        icon: SvgPicture.asset(
                          'assets/icons/ic_generate.svg',
                          width: 24.w,
                          height: 24.w,
                        ),
                        isSelected: controller.editIconSelected.value == EditIconEnum.generateText,
                        title: 'generate'.tr,
                        onTap: controller.onTapGenerateText,
                        selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
                      ),
                    ),
                    SizedBox(width: 22.w),
                    EditIcon(
                      icon: Icon(
                        Icons.edit_note,
                        size: 28.w,
                      ),
                      isSelected: false,
                      title: 'Edit',
                      onTap: () {
                        controller.onDoubleTapText(controller.textSelectedEdit.value);
                      },
                      selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
                    ),
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
                        selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
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
                        selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
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
                        selectedIcon: SvgPicture.asset(
                          'assets/icons/ic_dot.svg',
                          width: 4.w,
                          height: 4.w,
                        ),
                        isSelected: controller.editIconSelected.value == EditIconEnum.align,
                        title: 'Align',
                        onTap: () {
                          controller.onTapChangeAlign();
                        },
                        selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
                      ),
                    ),
                    SizedBox(width: 22.w),
                    Obx(
                      () => EditIcon(
                        icon: Icon(Icons.text_decrease, size: 24.w, color: const Color(0xFF64748B)),
                        selectedIcon: SvgPicture.asset(
                          'assets/icons/ic_dot.svg',
                          width: 4.w,
                          height: 4.w,
                        ),
                        isSelected: controller.editIconSelected.value == EditIconEnum.size,
                        title: 'Size',
                        onTap: () {
                          controller.onTapChangeSize();
                        },
                        selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
                      ),
                    ),
                    SizedBox(width: 22.w),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return SizedBox(
          height: 66.w,
          width: double.infinity,
          child: Container(
            decoration:
                BoxDecoration(color: AppColors.primaryTextColor, borderRadius: BorderRadius.all(Radius.circular(16.w))),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 18.w),
                    child: GestureDetector(
                      onTap: () async {
                        controller.resetState();
                      },
                      child: SvgPicture.asset('assets/icons/ic_arrow_left_square.svg', width: 28.w, height: 28.w),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 32.w),
                    Obx(() => EditIcon(
                          icon: SvgPicture.asset(
                            'assets/icons/ic_generate.svg',
                            width: 24.w,
                            height: 24.w,
                          ),
                          isSelected: controller.editIconSelected.value == EditIconEnum.generateImage,
                          title: 'generate'.tr,
                          onTap: controller.onTapGenerateImage,
                          selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
                        )),
                    SizedBox(width: 32.w),
                    Obx(
                      () => EditIcon(
                        icon: SvgPicture.asset('assets/icons/ic_crop.svg', width: 24.w, height: 24.w),
                        isSelected: controller.editIconSelected.value == EditIconEnum.crop,
                        title: 'Crop',
                        onTap: controller.onTapCropImage,
                        selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
                      ),
                    ),
                    SizedBox(width: 32.w),
                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   padding: EdgeInsets.only(right: 24.w),
                    //   child: Obx(() => EditIcon(
                    //         icon: Icon(Icons.text_fields, size: 24.w, color: const Color(0xFF64748B)),
                    //         selectedIcon: SvgPicture.asset(
                    //           'assets/icons/ic_dot.svg',
                    //           width: 4.w,
                    //           height: 4.w,
                    //         ),
                    //         isSelected: controller.pageEnum.value == PageEnum.back,
                    //         title: 'Text',
                    //         onTap: () {
                    //           controller.onTapText(max(controller.textSelectedEdit.value, 0));
                    //         },
                    //         selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
                    //       )),
                    // )
                  ],
                ),
              ],
            ),
          ),
        );
      }
    } else {
      return SizedBox(
        height: 66.w,
        width: double.infinity,
        child: Container(
          decoration:
              BoxDecoration(color: AppColors.primaryTextColor, borderRadius: BorderRadius.all(Radius.circular(16.w))),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => EditIcon(
                        icon: SvgPicture.asset(
                          'assets/icons/ic_front.svg',
                          width: 24.w,
                          height: 24.w,
                          color: const Color(0xFF64748B),
                        ),
                        selectedIcon: SvgPicture.asset(
                          'assets/icons/ic_dot.svg',
                          width: 4.w,
                          height: 4.w,
                        ),
                        isSelected: controller.pageEnum.value == PageEnum.front,
                        title: 'Front',
                        onTap: controller.onTapFront,
                        selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
                      )),
                  SizedBox(width: 32.w),
                  Obx(
                    () => EditIcon(
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
                      selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
