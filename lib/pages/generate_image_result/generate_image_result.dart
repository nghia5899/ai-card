import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:ai_ecard/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenerateImageResult extends StatefulWidget {
  final String url;
  const GenerateImageResult({Key? key, required this.url}) : super(key: key);

  @override
  State<GenerateImageResult> createState() => _GenerateImageResultState();
}

class _GenerateImageResultState extends State<GenerateImageResult> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Center(
          child: Column(
            children: [
              Image.network(widget.url,
              width: Get.width, fit: BoxFit.fitWidth,),
              SizedBox(height: 22.w,),
              CustomTextButton(
                title: 'Apply to card',
                onPressed: () async {
                  // Get.
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
