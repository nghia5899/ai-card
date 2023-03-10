import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatefulWidget {
  final Function()? onPressed;
  final String title;
  final String? subtext;
  Color? textColor;
  Color? borderColor;
  Color? backgroundColor;
  TextStyle? titleStyle;
  double? width;
  double? height;
  double? borderRadius;
  CustomTextButton(
      {Key? key,
      required this.title,
      this.subtext,
      this.onPressed,
      this.borderColor,
      this.backgroundColor,
      this.titleStyle,
      this.width,
      this.height,
        this.borderRadius
      })
      : super(key: key);

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return CustomAppButton(
      width: widget.width,
      height: widget.height,
      onPressed: widget.onPressed,
      borderColor: widget.borderColor,
      borderRadius: widget.borderRadius,
      backgroundColor: widget.backgroundColor ?? AppColors.textButtonColor,
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Text(widget.title, style: widget.titleStyle ?? AppStyles.textButtonTitle),
            (widget.subtext != null)
                ? Text(
                    widget.subtext!,
                    style: AppStyles.subTextButtonTitle,
                  )
                : const SizedBox(height: 0),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
