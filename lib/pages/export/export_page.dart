import 'dart:typed_data';
import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/pages/edit/edit_controller.dart';
import 'package:ai_ecard/pages/export/export_controller.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_icon.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/animation_fold_card.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:ai_ecard/widgets/custom_text_button.dart';
import 'package:ai_ecard/widgets/slider_page_view.dart';
import 'package:ai_ecard/widgets/edit_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExportPage extends GetView<ExportController> {
  const ExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    double imageWidth = Get.width - 48.w;
    double imageHeight = imageWidth * controller.frontCardHeight / controller.frontCardWidth;
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
                  child: SvgPicture.asset(AppIcons.iconClose, width: 28.w, height: 28.w),
                ),
              ],
            ),
          ),
          leadingWidth: 168.w,
          elevation: 0,
          actions: [
            Center(
              child: CustomTextButton(
                title: 'save'.tr,
                titleStyle: AppStyles.textButtonTitle.copyWith(fontSize: AppStyles.smallSize),
                backgroundColor: AppColors.smallButtonColor,
                height: 24.w,
                width: 48.w,
                borderRadius: 6.w,
                onPressed: controller.saveFile,
              ),
            ),
            SizedBox(width: 24.w),
            GestureDetector(
              onTap: controller.shareFile,
              child: SvgPicture.asset(AppIcons.iconUpload, width: 24.w, height: 24.w),
            ),
            SizedBox(width: 24.w)
          ],
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: 16.w),
                SizedBox(
                  width: imageWidth + 2.w,
                  height: imageHeight,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          child: FoldingCard.create(
                            key: controller.foldingCardKey,
                            frontWidget: Stack(
                              children: [
                                Container(width: imageWidth, height: imageHeight, color: Colors.white),
                                Image.memory(
                                  controller.front.value.image,
                                  width: imageWidth,
                                  height: imageHeight,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            innerWidget: Obx(() => SizedBox(
                              width: imageWidth * 2,
                              height: imageHeight,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(
                                    width: imageWidth,
                                    height: imageHeight,
                                    child: Stack(
                                      children: [
                                        Container(width: imageWidth, height: imageHeight, color: Colors.white),
                                        Image.memory(
                                          (controller.inside.isNotEmpty)
                                              ? controller.inside.value[0].image
                                              : controller.front.value.image,
                                          width: imageWidth,
                                          height: imageHeight,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 2.w),
                                    child: SizedBox(
                                      width: imageWidth,
                                      height: imageHeight,
                                      child: Stack(
                                        children: [
                                          Container(width: imageWidth, height: imageHeight, color: Colors.white),
                                          Image.memory(
                                            (controller.inside.isNotEmpty)
                                                ? controller.inside.value[1].image
                                                : controller.front.value.image,
                                            width: imageWidth,
                                            height: imageHeight,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            cellSize: Size(imageWidth, imageHeight),
                            onOpen: () {
                              controller.isAnimationFoldRunning.value = false;
                            },
                            onClose: () {
                              controller.isAnimationFoldRunning.value = false;
                            },
                          ),
                        ),
                      ),
                      Obx(() {
                        if (controller.isAnimationFoldRunning.value) {
                          return const SizedBox();
                        } else if (controller.pageEnum.value == PageEnum.inside) {
                          // có thẻ tách nhỏ
                          return Obx(
                                () => SliderPageView(
                              autoPlay: false,
                              isEnabledCell: false,
                              currentPos: controller.sliderIndex.value,
                              height: imageHeight,
                              viewportFraction: (imageWidth + 2.w) / Get.width,
                              onChanged: (index) {
                                controller.sliderIndex.value = index;
                              },
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                                  child: SizedBox(
                                    width: imageWidth,
                                    height: imageHeight,
                                    child: Stack(
                                      children: [
                                        Container(width: imageWidth, height: imageHeight, color: Colors.white),
                                        Obx(() {
                                            return Container(
                                              width: imageWidth,
                                              alignment: Alignment.topCenter,
                                              child: Image(
                                                width: imageWidth,
                                                height: imageHeight,
                                                fit: BoxFit.cover,
                                                image: Image.memory(
                                                  controller.inside.value[0].image,
                                                  width: imageWidth,
                                                  height: imageHeight,
                                                  fit: BoxFit.cover,
                                                ).image,
                                              ),
                                            );
                                        }),
                                        for (int i = 0; i < controller.texts.value.length; i++)
                                        //có thể tách nhỏ
                                          Obx(() {
                                            return Positioned(
                                                top: controller.texts.value[i].positionTop,
                                                left: controller.texts.value[i].positionLeft,
                                                child: Text(
                                                  controller.texts.value[i].text ?? '',
                                                  textAlign: controller.texts.value[i].textAlign,
                                                  style: TextStyle(
                                                    color: controller.texts.value[i].color,
                                                    fontSize: controller.texts.value[i].fontSize,
                                                    fontFamily: controller.texts.value[i].fontFamily,
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                              );
                                          }),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                                  child: SizedBox(
                                    width: imageWidth,
                                    height: imageHeight,
                                    child: Stack(
                                      children: [
                                        Container(width: imageWidth, height: imageHeight, color: Colors.white),
                                        //có thể tach nhỏ
                                        Obx(() {
                                            return Container(
                                              width: imageWidth,
                                              height: imageHeight,
                                              alignment: Alignment.topCenter,
                                              child: Image(
                                                width: imageWidth,
                                                height: imageHeight,
                                                fit: BoxFit.cover,
                                                image: Image.memory(
                                                  controller.inside.value[1].image,
                                                  width: imageWidth,
                                                  height: imageHeight,
                                                  fit: BoxFit.cover,
                                                ).image,
                                              ),
                                            );
                                        }),
                                        for (int i = 0; i < controller.texts.value.length; i++)
                                        // có thể tách nhỏ
                                          Obx(() {
                                              return Positioned(
                                                top: controller.texts.value[i].positionTop,
                                                left: controller.texts.value[i].positionLeft,
                                                child: Text(
                                                  controller.texts.value[i].text ?? '',
                                                  textAlign: controller.texts.value[i].textAlign,
                                                  style: TextStyle(
                                                      color: controller.texts.value[i].color,
                                                      fontSize: controller.texts.value[i].fontSize,
                                                      fontFamily: controller.texts.value[i].fontFamily,
                                                      overflow: TextOverflow.clip),
                                                ),
                                              );
                                          }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            child: Container(
                              width: imageWidth,
                              height: imageHeight,
                              alignment: Alignment.centerRight,
                              child: Stack(
                                children: [
                                  Container(
                                    width: imageWidth,
                                    height: imageHeight,
                                    color: Colors.white,
                                  ),
                                  Image.memory(controller.front.value.image, width: imageWidth, height: imageHeight),
                                  for (int i = 0; i < controller.texts.value.length; i++)
                                  //có thể tách nhỏ
                                    Obx(() {
                                        return Positioned(
                                          top: controller.texts.value[i].positionTop,
                                          left: controller.texts.value[i].positionLeft,
                                          child: Text(
                                            controller.texts.value[i].text ?? '',
                                            textAlign: controller.texts.value[i].textAlign,
                                            style: TextStyle(
                                              color: controller.texts.value[i].color,
                                              fontSize: controller.texts.value[i].fontSize,
                                              fontFamily: controller.texts.value[i].fontFamily,
                                            ),
                                          ),
                                        );
                                    })
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
            tabGroup()
          ],
        ),
      ),
    );
  }

  Widget tabGroup() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: SizedBox(
          height: 66.w,
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.primaryTextColor, borderRadius: BorderRadius.all(Radius.circular(16.w))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() =>
                    EditIcon(
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
                Obx(() =>
                    EditIcon(
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
                    )),
                SizedBox(width: 32.w),
                // Obx(() => EditIcon(
                //       icon: SvgPicture.asset(
                //         'assets/icons/ic_back.svg',
                //         width: 24.w,
                //         height: 24.w,
                //         color: const Color(0xFF64748B),
                //       ),
                //       selectedIcon: SvgPicture.asset(
                //         'assets/icons/ic_dot.svg',
                //         width: 4.w,
                //         height: 4.w,
                //       ),
                //       isSelected: controller.pageEnum.value == PageEnum.back,
                //       title: 'Back',
                //       onTap: controller.onTapBack,
                //       selectTitleStyle: AppStyles.subTexTitle.copyWith(color: const Color(0xFF1B514A)),
                //     )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  Widget imagePainter({required double width, required double height, required Uint8List image, required List<TextInfo> textInfo}) {
    return Stack(children: [
      Container(
        width: width,
        alignment: Alignment.topCenter,
        child: Image(
          image: Image
              .memory(image)
              .image,
          width: width,
          height: height,
          fit: BoxFit.cover,
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
