import 'package:ai_ecard/pages/start/start_controller.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            SizedBox(height: 524.w, child: const SliderPageView()),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  CustomTextButton(
                    title: 'subscribe_premium'.tr,
                    subtext: 'premium_price'.tr,
                  ),
                  SizedBox(height: 8.w),
                  CustomAppButton (
                    child: Center(
                      child: Row(
                        children: [
                          const Spacer(),
                          SizedBox(height: 24.w, width: 24.w, child: Image.asset(AppIcons.iconSA, fit: BoxFit.fill)),
                          SizedBox(width: 8.w),
                          Text('login_sa_account'.tr, style: AppStyles.primaryButtonTitle,),
                          const Spacer(),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      print('hello');
                      await controller.authenticate();
                    },
                  ),
                  SizedBox(height: 16.w),
                  InkWell(
                    onTap: () async {
                      controller.showAd();
                    },
                    child: Text('watch_ads_recommend'.tr, style: AppStyles.subTexTitle),
                  ),
                  SizedBox(height: 16.w)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
