import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/pages/generate_image/generate_image_controller.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_icon.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:ai_ecard/widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GenerateImagePage extends GetView<GenerateImageController> {
  const GenerateImagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppScaffold(
        backGroundColor: AppColors.primaryBackGroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Generate images',
            style: TextStyle(color: Colors.black),
          ),
          toolbarHeight: 56.w,
          leading: Row(
            children: [
              SizedBox(
                width: 24.w,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: SvgPicture.asset(AppIcons.iconClose, width: 24.w, height: 24.w),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Describe what’s on your mind. For best results, be specific.',
                style: TextStyle(color: Color(0xFF0F172A), fontSize: 16.w, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 8.w),
              TextFormField(
                controller: controller.textController,
                onChanged: controller.updateContent,
                style: const TextStyle(
                  fontWeight: FontWeight.w600
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          new Radius.circular(8.w),
                        ),
                        borderSide: BorderSide(color: Colors.white24)),
                    fillColor: Colors.white,
                    filled: true),
              ),
              SizedBox(height: 2.w),
              Row(
                children: [
                  const Spacer(),
                  Obx(() => Text(
                    '${controller.words}/8 words',
                    style:
                    TextStyle(color: const Color(0xFF64748B), fontSize: 10.w, fontWeight: FontWeight.w500),
                  ))
                ],
              ),
              SizedBox(height: 22.w),
              Text(
                'Keyword suggestion',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 14.w, fontWeight: FontWeight.w500),
              ),
              Obx(
                () => Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(controller.keywordSuggest.length, (index) {
                    return Obx(() => Padding(
                      padding: EdgeInsets.only(right: 8.w, top: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          controller.updateSelectedItem(index);
                        },
                        child: suggestButton(controller.keywordSuggest.value[index], controller.selectedIndex.value == index),
                      ),
                    ));
                  }),
                ),
              ),
              const Spacer(),
              Obx(() => CustomAppButton(
                    height: 44.w,
                    backgroundColor: controller.selectedIndex.value >= 0 ? null : const Color(0xFF334155),
                    enabled: controller.selectedIndex.value >= 0,
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Generate',
                          style: TextStyle(
                              color:
                                  controller.generateImageContent.value.isNotEmpty ? Colors.white : Color(0xFF94A3B8),
                              fontSize: 16.w,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                      ],
                    ),
                    onPressed: () {
                      controller.getPrompt();
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget suggestButton(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 8.w),
      decoration: BoxDecoration(
          color: const Color(0xFFE0E3DE),
          border: isSelected ? Border.all(color: Color(0xFF1B514A)) : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8.w)),
      child: Text(
        text,
        style: TextStyle(
            color: isSelected ? const Color(0xFF1B514A) : const Color(0xFF0F172A),
            fontSize: 14.w,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
