import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListColor extends StatefulWidget {
  List<Color> colors;
  Function(int) onTapColor;
  int selectedIndex;

  ListColor({Key? key, required this.colors, required this.onTapColor, required this.selectedIndex}) : super(key: key);

  @override
  State<ListColor> createState() => _ListColorState();
}

class _ListColorState extends State<ListColor> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 44.w),
        SizedBox(
          width: double.infinity,
          height: 32.w,
          child: ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        widget.onTapColor.call(selectedIndex);
                      });
                    },
                    child: colorItem(widget.colors[index], selectedIndex == index),
                  ),
              separatorBuilder: (_, __) => SizedBox(width: 16.w),
              itemCount: widget.colors.length),
        ),
      ],
    );
  }

  Widget colorItem(Color color, bool isSelected) {
    return Container(
      height: 32.w,
      width: 32.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.w), color: color),
      child: isSelected
          ? SvgPicture.asset('assets/icons/ic_check.svg', width: 24.w, height: 24.w)
          : SizedBox(
              width: 24.w,
              height: 24.w,
            ),
    );
  }
}
