import 'package:ai_ecard/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExportBottomSheet extends StatefulWidget {
  String title;
  Function()? onTapImage;
  Function()? onTapPdf;
  ExportBottomSheet({Key? key, required this.title, this.onTapImage, this.onTapPdf}) : super(key: key);

  @override
  State<ExportBottomSheet> createState() => _ExportBottomSheetState();
}

class _ExportBottomSheetState extends State<ExportBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))
      ),
      child: Column(
        children: [
          SizedBox(height: 16.w),
          Text(widget.title, style: TextStyle(color: const Color(0xFF0F172A), fontSize: AppStyles.largeSize, fontWeight: AppStyles.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(onPressed: widget.onTapImage, icon: Icon(Icons.image, size: 44.w)),
                  SizedBox(height: 8.w,),
                  Text('Export as Image', style: TextStyle(color: const Color(0xFF0F172A), fontSize: AppStyles.mediumSize, fontWeight: AppStyles.regular ),)
                ],
              ),
              Column(
                children: [
                  IconButton(onPressed: widget.onTapPdf, icon: Icon(Icons.picture_as_pdf, size: 44.w)),
                  SizedBox(height: 8.w,),
                  Text('Export as PDF', style: TextStyle(color: const Color(0xFF0F172A), fontSize: AppStyles.mediumSize, fontWeight: AppStyles.regular ),)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
