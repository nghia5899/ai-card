import 'dart:math';

import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/pages/generate_content/generate_content_controller.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_icon.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:ai_ecard/widgets/custom_app_button.dart';
import 'package:ai_ecard/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GenerateContentPage extends GetView<GenerateContentController> {
  const GenerateContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: AppScaffold(
        backGroundColor: AppColors.primaryBackGroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Generate content',
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
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 22.w, horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Describe what kind of content you want to create. For better results, add detailed phrases.',
                    style: TextStyle(color: const Color(0xFF0F172A), fontSize: 16.w, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 8.w),
                  TextFormField(
                    controller: controller.textController,
                    onChanged: controller.updateContent,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.w),
                            ),
                            borderSide: const BorderSide(color: Colors.white24)),
                        labelStyle: const TextStyle(color: Colors.white),
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
                  SizedBox(height: 8.w),
                  Text(
                    'Keyword suggestion',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 14.w, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.w),
                  SizedBox(
                    height: 40.w,
                    width: Get.width,
                    child: Obx(
                      () =>ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: min(controller.keywordSuggest.value.length, 10),
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(() => Padding(
                              padding: EdgeInsets.only(right: 8.w, top: 8.w),
                              child: GestureDetector(
                                onTap: () {
                                  controller.updateSelectedItem(index);
                                },
                                child: suggestButton(
                                    controller.keywordSuggest.value[index], controller.selectedIndex.value == index),
                              ),
                            ));
                          }),
                    ),
                  ),
                  SizedBox(height: 24.w),
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
                                  color: controller.generateContent.value.isNotEmpty
                                      ? Colors.white
                                      : const Color(0xFF94A3B8),
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                          ],
                        ),
                        onPressed: () {
                          controller.getPrompt();
                        },
                      )),
                ],
              ),
            ),
            SizedBox(height: 16.w),
            Divider(
              color: const Color(0xFFCBD5E1),
              height: 2.w,
              thickness: 2.w,
            ),
            SizedBox(
              height: 16.w,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI-generated content',
                      style: TextStyle(color: const Color(0xFF64748B), fontSize: 14.w, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 16.w),
                    Expanded(
                        child: Obx(() => ListView.separated(
                            padding: EdgeInsets.only(bottom: 32.w),
                            itemBuilder: (context, index) => generatedContent(context, index),
                            separatorBuilder: (_, __) => SizedBox(
                                  height: 5.w,
                                ),
                            itemCount: controller.generateContentResult.length)))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget generatedContent(BuildContext context, int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration:
                    const BoxDecoration(color: Color(0xFFE0E3DE), borderRadius: BorderRadius.all(Radius.circular(10))),
                constraints: BoxConstraints(
                  minWidth: 0,
                  maxWidth: MediaQuery.of(context).size.width - 48.w,
                ),
                child: Text(
                  controller.generateContentResult[index],
                  style: TextStyle(color: const Color(0xFF0F172A), fontSize: 16.w, fontWeight: FontWeight.w400),
                )),
            Expanded(child: Container())
          ],
        ),
        SizedBox(
          height: 8.w,
        ),
        Row(
          children: [
            const Spacer(),
            CustomTextButton(
              title: 'Apply to card',
              width: 110.w,
              height: 44.w,
              borderColor: const Color(0xFF1B514A),
              backgroundColor: Colors.transparent,
              onPressed: () {
                Get.back(result: controller.generateContentResult[index]);
              },
            ),
          ],
        )
      ],
    );
  }
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
