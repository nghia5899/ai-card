import 'dart:typed_data';

import 'package:ai_ecard/helper/file_helper.dart';
import 'package:ai_ecard/pages/purchase/purchase_controller.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_icon.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:ai_ecard/widgets/custom_app_button.dart';
import 'package:ai_ecard/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PurchasePage extends GetView<PurchaseController> {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backGroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 56.w,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(
                  AppIcons.iconClose,
                  width: 24.w,
                  height: 24.w,
                  color: AppColors.primaryTextColor,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 144.w,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: ListView(
                children: [
                  SizedBox(
                    width: 220.w,
                    height: 237.w,
                    child: Image.asset(AppIcons.iconGroup),
                  ),
                  SizedBox(height: 62.w),
                  Text('purchase_page_title'.tr, style: AppStyles.pageHeader),
                  SizedBox(height: 33.w),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_tick_square.svg'),
                      SizedBox(width: 10.w),
                      Text(
                        'Unlock over 500 design templates',
                        style: AppStyles.descriptionText,
                      )
                    ],
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_tick_square.svg'),
                      SizedBox(width: 10.w),
                      Text('Ad-free', style: AppStyles.descriptionText)
                    ],
                  ),
                  SizedBox(height: 10.w),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/ic_tick_square.svg'),
                      SizedBox(width: 10.w),
                      Text('No watermarks', style: AppStyles.descriptionText)
                    ],
                  ),
                  SizedBox(height: 155.w),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 155.w,
                width: double.infinity,
                child: Column(
                  children: [
                    _suggestPurchase(false),
                    SizedBox(height: 12.w),
                    CustomAppButton(
                      child: false
                          ? Image.asset('assets/images/2_year.png', height: 32.w, fit: BoxFit.fitHeight)
                          : Image.asset('assets/images/2_year.png', height: 32.w, fit: BoxFit.fitHeight),
                      backgroundColor: AppColors.primaryTextColor,
                      onPressed: () async {
                        Uint8List image = await FileHelper.createImage(SizedBox(
                          width: 220.w,
                          height: 237.w,
                          child: Image.asset(AppIcons.iconGroup),
                        ));
                        Get.toNamed(AppRoutes.homeDefault);
                      },
                    ),
                    SizedBox(height: 4.w),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        'Cancel anytime.',
                        style: AppStyles.subTexTitle.copyWith(color: const Color.fromRGBO(255, 255, 255, 0.6)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _suggestPurchase(bool isSALogin) {
    return isSALogin
        ? Text('suggest_purchase_is_login'.tr, style: AppStyles.suggestText, textAlign: TextAlign.center)
        : Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(text: 'login_sa_account'.tr, style: AppStyles.descriptionText),
          TextSpan(text: " ${'suggest_purchase_not_login'.tr}", style: AppStyles.suggestText)
        ]),
        textAlign: TextAlign.center,
      ),
    );
  }

// Widget _primaryPrice(bool isSALogin){
//   return isSALogin ? : ;
// }
}
