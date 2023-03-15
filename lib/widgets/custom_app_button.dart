import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppButton extends StatefulWidget {
  final Function()? onPressed;
  final Widget child;
  Color? textColor;
  Color? borderColor;
  double? borderRadius;
  Color? backgroundColor;
  double? height;
  double? width;
  bool enabled;

  CustomAppButton(
      {Key? key,
      required this.child,
      this.onPressed,
      this.borderColor,
      this.borderRadius,
      this.backgroundColor,
      this.height,
      this.width,
      this.enabled = true})
      : super(key: key);

  @override
  State<CustomAppButton> createState() => _CustomAppButtonState();
}

class _CustomAppButtonState extends State<CustomAppButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 56.w,
      decoration: BoxDecoration(
          color: widget.backgroundColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 8.w))),
      child: MaterialButton(
        minWidth: widget.width ?? double.infinity,
        onPressed: () {
          if(widget.enabled) {
            widget.onPressed?.call();
          }
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: widget.borderColor ?? Colors.transparent
          ),
            borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius ?? 8.w))),
        child: Center(
          child: widget.child,
        ),
      ),
    );
    // return ElevatedButton(
    //   onPressed: widget.onPressed,
    //   style: ButtonStyle(
    //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
    //         borderRadius: widget.borderRadius ?? BorderRadius.circular(8.w),
    //         side: BorderSide(color: widget.borderColor ?? Colors.transparent, width: 2))),
    //     backgroundColor: MaterialStateProperty.all<Color>(widget.backgroundColor ?? AppColors.primaryColor),
    //     minimumSize: MaterialStateProperty.all<Size>(
    //       Size(double.infinity, 56.w),
    //     ),
    //       surfaceTintColor: MaterialStateProperty.all<Color>(Colors.black)
    //   ),
    //   child: Center(
    //       child: widget.child
    //   ),
    // );
  }
}
