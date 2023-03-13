import 'dart:typed_data';

import 'package:ai_ecard/helper/file_helper.dart';
import 'package:ai_ecard/pages/export/export_controller.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_icon.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:ai_ecard/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as image;

class ExportPage extends GetView<ExportController> {
  const ExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
              onPressed: saveImage,
            ),
          ),
          SizedBox(width: 24.w),
          GestureDetector(
            onTap: shareImage,
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
                  Image(image: Image.memory(controller.stack.value[0]).image,
                      width: 327.w, fit: BoxFit.fitWidth),
                  // Image(image: Image.memory(data).image, width: 327.w, fit: BoxFit.fitWidth),
                  SizedBox(height: 70.w)
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 66.w,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.primaryTextColor, borderRadius: BorderRadius.all(Radius.circular(16.w))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Spacer(),
                          SvgPicture.asset('assets/icons/ic_generate.svg', width: 24.w, height: 24.w),
                          SizedBox(height: 5.w),
                          Text('generate'.tr, style: AppStyles.descriptionIconText),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(width: 32.w),
                      Column(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              // final a = await ImageCropper
                            },
                            child: SvgPicture.asset('assets/icons/ic_crop.svg', width: 24.w, height: 24.w),
                          ),
                          SizedBox(height: 5.w),
                          Text('crop'.tr, style: AppStyles.descriptionIconText),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> showToast(String text) async {
    Fluttertoast.showToast(msg: text, toastLength: Toast.LENGTH_SHORT);
  }

  Future<void> saveImage() async {
    await FileHelper.saveFileToGallery('test.png', 'AI-Ecard', controller.stack.value[controller.stack.value.length - 1]);
    showToast('Save successfully');
  }

  Future<void> shareImage() async {
    await FileHelper.saveFileToGallery('test.png', 'AI-Ecard', controller.stack.value[controller.stack.value.length - 1]);
    await FileHelper.shareFile(files: ['test.png'], text: 'AI-Ecard', subject: 'AI-Ecard');
    showToast('Share successfully');
  }
}
