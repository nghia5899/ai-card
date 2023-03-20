import 'package:ai_ecard/styles/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListAlign extends StatefulWidget {
  List<TextAlign> aligns = [TextAlign.left, TextAlign.center, TextAlign.right];
  Function(TextAlign) onTapAlign;
  TextAlign selected;

  ListAlign({Key? key, required this.onTapAlign, required this.selected}) : super(key: key);

  @override
  State<ListAlign> createState() => _ListAlignState();
}

class _ListAlignState extends State<ListAlign> {
  late TextAlign _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 28.w),
        SizedBox(
          width: double.infinity,
          height: 48.w,
          child: ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) =>
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selected = widget.aligns[index];
                        widget.onTapAlign.call(_selected);
                      });
                    },
                    child: alignItem(widget.aligns[index], _selected),
                  ),
              separatorBuilder: (_, __) => SizedBox(width: 16.w),
              itemCount: widget.aligns.length),
        ),
      ],
    );
  }

  Widget alignItem(TextAlign align, TextAlign selected) {
    return SizedBox(
      height: 48.w,
      child: align == selected
          ? icon(align: align, color: const Color(0xFF1B514A))
          : icon(align: align),
    );
  }

  Widget icon({required TextAlign align, Color? color}) {
    String path = '';
    String text = '';
    switch (align) {
      case TextAlign.center:
        {
          path = 'assets/icons/ic_text_align_center.svg';
          text = 'Center';
          break;
        }
      case TextAlign.left:
        {
          path = 'assets/icons/ic_text_align_left.svg';
          text = 'Left';
          break;
        }
      case TextAlign.right:
        {
          path = 'assets/icons/ic_text_align_right.svg';
          text = 'Right';
          break;
        }
      default:
        {
          path = 'assets/icons/ic_text_align_center.svg';
          text = 'Center';
          break;
        }
    }
    return Column(
      children: [
        SvgPicture.asset(path, width: 24.w, height: 24.w, color: color),
        SizedBox(height: 8.w),
        Text(text, style: AppStyles.descriptionIconText.copyWith(color: color))
      ],
    );
  }
}
