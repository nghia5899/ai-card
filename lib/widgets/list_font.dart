import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListFont extends StatefulWidget {
  List<String> fonts;
  Function(int) onTapFont;
  Function(double) onSizeChange;
  int selectedIndex;
  double fontSize;
  ListFont(
      {Key? key, required this.fonts, required this.onTapFont, required this.selectedIndex, required this.onSizeChange, required this.fontSize})
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
    fontSize = widget.fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 24.w,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          child: Slider(min: 1, max: 100, value: fontSize, onChanged:(value){
            setState(() {
              fontSize = value;
              widget.onSizeChange.call(value);
            });
          }),
        ),
        SizedBox(height: 20.w),
        SizedBox(
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
        ),
      ],
    );
  }

  Widget fontItem(String fontFamily, bool isSelected) {
    return Container(
      height: 32.w,
      width: 32.w,
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
