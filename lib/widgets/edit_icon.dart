import 'package:ai_ecard/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditIcon extends StatefulWidget {
  Widget icon;
  Widget? selectedIcon;
  String? title;
  bool isSelected;
  TextStyle? selectTitleStyle;
  Function() onTap;

  EditIcon(
      {Key? key,
      required this.icon,
      required this.isSelected,
      this.title,
      this.selectedIcon,
      this.selectTitleStyle,
      required this.onTap})
      : super(key: key);

  @override
  State<EditIcon> createState() => _EditIconState();
}

class _EditIconState extends State<EditIcon> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        height: 66.w,
        child: Column(
          children: [
            const Spacer(),
            widget.icon,
            SizedBox(height: 4.w),
            Text(widget.title ?? '',
                style: widget.isSelected
                    ? widget.selectTitleStyle ?? AppStyles.descriptionIconText
                    : AppStyles.descriptionIconText),
            (widget.isSelected) ? widget.selectedIcon ?? SizedBox(height: 4.w): SizedBox(height: 4.w),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
