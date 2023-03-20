import 'package:ai_ecard/pages/edit/edit_controller.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_icon.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/animation_fold_card.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:ai_ecard/widgets/custom_text_button.dart';
import 'package:ai_ecard/widgets/draggable_text.dart';
import 'package:ai_ecard/widgets/slider_page_view.dart';
import 'package:ai_ecard/widgets/tab_group.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditPage extends GetView<EditController> {
  const EditPage({super.key});

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
                Obx(() => GestureDetector(
                  onTap: () {
                    if (controller.isEdit.value) {
                      controller.resetState();
                    } else {
                      Get.back();
                    }
                  },
                  child: (controller.isEdit.value)? Icon(Icons.undo, size: 28.w, color: Colors.black87) :SvgPicture.asset(AppIcons.iconClose, width: 28.w, height: 28.w),
                ),),
                SizedBox(width: 16.w),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.undo();
                    },
                    child: (controller.isEdit.value)
                        ? const SizedBox()
                        : SvgPicture.asset(AppIcons.iconUndo,
                            width: 28.w,
                            height: 28.w,
                            color: controller.undoEnabled.value ? Colors.black : Colors.black45),
                  ),
                ),
                SizedBox(width: 16.w),
                Obx(() {
                  if (controller.isEdit.value) {
                    return SizedBox();
                  } else {
                    return GestureDetector(
                      onTap: () {
                        controller.redo();
                      },
                      child: SvgPicture.asset(AppIcons.iconRedo,
                          width: 28.w,
                          height: 28.w,
                          color: controller.redoEnabled.value ? Colors.black : Colors.black45),
                    );
                  }
                }),
              ],
            ),
          ),
          leadingWidth: 168.w,
          elevation: 0,
          actions: [
            Obx(
              () => Center(
                child: (!controller.isEdit.value)
                    ? CustomTextButton(
                        title: 'next'.tr,
                        titleStyle: AppStyles.textButtonTitle.copyWith(fontSize: AppStyles.smallSize),
                        backgroundColor: AppColors.smallButtonColor,
                        height: 24.w,
                        width: 48.w,
                        borderRadius: 6.w,
                        onPressed: controller.toExportPage)
                    : GestureDetector(
                        onTap: () {
                          controller.editDone();
                        },
                        child: Icon(Icons.check, size: 28.w, color: Colors.black),
                      ),
              ),
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
                        child: GestureDetector(
                          onTap: controller.onTapImage,
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
                                GestureDetector(
                                  onTap: controller.onTapImage,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                                    child: SizedBox(
                                      width: imageWidth,
                                      height: imageHeight,
                                      child: Stack(
                                        children: [
                                          Container(width: imageWidth, height: imageHeight, color: Colors.white),
                                          Obx(() {
                                            if (controller.isEdit.value &&
                                                !controller.isEditText.value &&
                                                controller.pageEnum.value == PageEnum.inside &&
                                                controller.sliderIndex.value == 0) {
                                              return ExtendedImage.memory((controller.inside.value[0].image),
                                                  width: imageWidth,
                                                  height: imageHeight,
                                                  fit: BoxFit.contain,
                                                  mode: ExtendedImageMode.editor,
                                                  extendedImageEditorKey: controller.editorKey,
                                                  cacheRawData: true,
                                                  filterQuality: FilterQuality.high, initEditorConfigHandler: (state) {
                                                return EditorConfig(
                                                    cornerSize: const Size(0, 0),
                                                    cornerColor: Colors.blueAccent,
                                                    maxScale: 20.0,
                                                    lineHeight: 2.w,
                                                    lineColor: Colors.blueAccent,
                                                    cropRectPadding: EdgeInsets.all(0.w),
                                                    reverseMousePointerScrollDirection: true,
                                                    cropAspectRatio: imageWidth / imageHeight);
                                              });
                                            } else {
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
                                            }
                                          }),
                                          for (int i = 0; i < controller.texts.value.length; i++)
                                            Obx(() {
                                              if (controller.isEdit.value &&
                                                  controller.isEditText.value &&
                                                  controller.isMoveText.value &&
                                                  controller.textSelectedEdit.value == i &&
                                                  controller.sliderIndex.value == 0) {
                                                return Obx(() => DraggableText(
                                                      textInfo: controller.texts.value[i],
                                                    ));
                                              } else if(controller.sliderIndex.value == 0) {
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
                                                      textAlign: controller.texts.value[i].textAlign,
                                                      style: TextStyle(
                                                        color: controller.texts.value[i].color,
                                                        fontSize: controller.texts.value[i].fontSize,
                                                        fontFamily: controller.texts.value[i].fontFamily,
                                                        overflow: TextOverflow.clip,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox(width: 0, height: 0);
                                              }
                                            }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: controller.onTapImage,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                                    child: SizedBox(
                                      width: imageWidth,
                                      height: imageHeight,
                                      child: Stack(
                                        children: [
                                          Container(width: imageWidth, height: imageHeight, color: Colors.white),
                                          //có thể tach nhỏ
                                          Obx(() {
                                            if (controller.isEdit.value &&
                                                !controller.isEditText.value &&
                                                controller.pageEnum.value == PageEnum.inside &&
                                                controller.sliderIndex.value == 1) {
                                              return ExtendedImage.memory((controller.inside.value[1].image),
                                                  width: imageWidth,
                                                  height: imageHeight,
                                                  fit: BoxFit.contain,
                                                  mode: ExtendedImageMode.editor,
                                                  extendedImageEditorKey: controller.editorKey,
                                                  cacheRawData: true, initEditorConfigHandler: (state) {
                                                return EditorConfig(
                                                    cornerSize: const Size(0, 0),
                                                    cornerColor: Colors.blueAccent,
                                                    lineHeight: 2.w,
                                                    maxScale: 10.0,
                                                    lineColor: Colors.blueAccent,
                                                    cropRectPadding: EdgeInsets.all(0.w),
                                                    cropAspectRatio: imageWidth / imageHeight);
                                              });
                                            } else {
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
                                            }
                                          }),
                                          for (int i = 0; i < controller.texts.value.length; i++)
                                            Obx(() {
                                              if (controller.isEdit.value &&
                                                  controller.isEditText.value &&
                                                  controller.isMoveText.value &&
                                                  controller.textSelectedEdit.value == i &&
                                                  controller.sliderIndex.value == 1) {
                                                return Obx(() => DraggableText(
                                                      textInfo: controller.texts.value[i],
                                                    ));
                                              } else if(controller.sliderIndex.value == 1) {
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
                                                      textAlign: controller.texts.value[i].textAlign,
                                                      style: TextStyle(
                                                          color: controller.texts.value[i].color,
                                                          fontSize: controller.texts.value[i].fontSize,
                                                          fontFamily: controller.texts.value[i].fontFamily,
                                                          overflow: TextOverflow.clip),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox(width: 0, height: 0);
                                              }
                                            }),
                                        ],
                                      ),
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
                                      if (controller.isEdit.value &&
                                          controller.isEditText.value &&
                                          controller.isMoveText.value &&
                                          controller.textSelectedEdit.value == i) {
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
                                              textAlign: controller.texts.value[i].textAlign,
                                              style: TextStyle(
                                                color: controller.texts.value[i].color,
                                                fontSize: controller.texts.value[i].fontSize,
                                                fontFamily: controller.texts.value[i].fontFamily,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Obx(
                  () => TabGroup(isEdit: controller.isEdit.value, isEditText: controller.isEditText.value),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}