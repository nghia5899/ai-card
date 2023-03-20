import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderSize extends StatefulWidget {
  Function(double) onSizeChange;
  double fontSize;
  SliderSize({Key? key, required this.fontSize, required this.onSizeChange}) : super(key: key);

  @override
  State<SliderSize> createState() => _SliderSizeState();
}

class _SliderSizeState extends State<SliderSize> {
  late double fontSize;

  @override
  void initState() {
    super.initState();
    fontSize = widget.fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.w,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      child: Slider(min: 1, max: 100, value: fontSize, onChanged:(value){
        setState(() {
          fontSize = value;
          widget.onSizeChange.call(value);
        });
      }),
    );
  }
}
