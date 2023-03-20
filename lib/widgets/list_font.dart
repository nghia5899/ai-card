import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListFont extends StatefulWidget {
  List<String> fonts;
  Function(int) onTapFont;
  int selectedIndex;
  ListFont(
      {Key? key, required this.fonts, required this.onTapFont, required this.selectedIndex})
      : super(key: key);

  @override
  State<ListFont> createState() => _ListFontState();
}

class _ListFontState extends State<ListFont> {
  late int selectedIndex;
  late double fontSize;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 32.w,
      child: ListView.separated(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    widget.onTapFont.call(selectedIndex = index);
                  });
                },
                child: fontItem(widget.fonts[index], selectedIndex == index),
              ),
          separatorBuilder: (_, __) => SizedBox(width: 16.w),
          itemCount: widget.fonts.length),
    );
  }

  Widget fontItem(String fontFamily, bool isSelected) {
    return Container(
      height: 36.w,
      width: 36.w,
      decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1B514A) : Colors.white, borderRadius: BorderRadius.circular(32.w)),
      child: Center(
        child: Text(
          'Aa',
          style: TextStyle(
              color: (isSelected) ? Colors.white : Colors.black,
              fontSize: 16.w,
              fontWeight: FontWeight.w400,
              fontFamily: fontFamily),
        ),
      ),
    );
  }
}
