import 'package:ai_ecard/models/parameters/generate_params.dart';
import 'package:ai_ecard/pages/start/start_controller.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/service/generate/generate_service.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_icon.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:ai_ecard/widgets/custom_app_button.dart';
import 'package:ai_ecard/widgets/custom_text_button.dart';
import 'package:ai_ecard/widgets/slider_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class StartPage extends GetView<StartController> {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backGroundColor: AppColors.primaryBackGroundColor,
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.w),
              child: SizedBox(
                  height: 524.w,
                  child: SliderPageView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: GestureDetector(
                            onTap: controller.toHome,
                            child: Container(
                              width: 375.w,
                              height: 480.w,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.w)),
                              child: Image.asset(
                                'assets/images/slider/img_birthday.png',
                                width: 375.w,
                                height: 480.w,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: GestureDetector(
                            onTap: controller.toHome,
                            child: Container(
                              width: 375.w,
                              height: 480.w,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.w)),
                              child: Image.asset(
                                'assets/images/slider/img_love.png',
                                width: 375.w,
                                height: 480.w,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: GestureDetector(
                            onTap: controller.toHome,
                            child: Container(
                              width: 375.w,
                              height: 480.w,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.w)),
                              child: Image.asset(
                                'assets/images/slider/img_new_baby.png',
                                width: 375.w,
                                height: 480.w,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: GestureDetector(
                            onTap: controller.toHome,
                            child: Container(
                              width: 375.w,
                              height: 480.w,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.w)),
                              child: Image.asset(
                                'assets/images/slider/img_wedding.png',
                                width: 375.w,
                                height: 480.w,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              width: double.infinity,
              height: Get.height,
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    Spacer(),
                    CustomTextButton(
                      title: 'subscribe_premium'.tr,
                      subtext: 'premium_price'.tr,
                      onPressed: () {
                        Get.toNamed(AppRoutes.purchase);
                      },
                    ),
                    SizedBox(height: 8.w),
                    CustomAppButton(
                      child: Center(
                        child: Row(
                          children: [
                            const Spacer(),
                            SizedBox(height: 24.w, width: 24.w, child: Image.asset(AppIcons.iconSA, fit: BoxFit.fill)),
                            SizedBox(width: 8.w),
                            Text('login_sa_account'.tr, style: AppStyles.primaryButtonTitle),
                            const Spacer(),
                          ],
                        ),
                      ),
                      onPressed: () async {
                        await controller.authenticate();
                      },
                    ),
                    SizedBox(height: 16.w),
                    InkWell(
                      onTap: controller.toHome,
                      child: Text('watch_ads_recommend'.tr, style: AppStyles.subTexTitle),
                    ),
                    SizedBox(height: 16.w)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
