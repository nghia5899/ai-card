import 'package:ai_ecard/styles/app_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderPageView extends StatefulWidget {
  List<Widget> children = [];
  bool autoPlay;
  double? height;
  double? viewportFraction;
  bool isEnabledCell;
  int currentPos;

  Function(int)? onChanged;

  SliderPageView(
      {super.key,
      required this.children,
      this.viewportFraction,
      this.autoPlay = true,
      this.height,
      this.onChanged,
      this.isEnabledCell = true,
      this.currentPos = 0});

  @override
  State<StatefulWidget> createState() {
    return _SliderPageViewState();
  }
}

class _SliderPageViewState extends State<SliderPageView> {
  late int _currentPos;
  List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children = widget.children;
    _currentPos = widget.currentPos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackGroundColor,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CarouselSlider.builder(
            itemCount: _children.length,
            options: CarouselOptions(
                autoPlay: widget.autoPlay,
                viewportFraction: widget.viewportFraction ?? 0.8,
                initialPage: _currentPos,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPos = index;
                    widget.onChanged?.call(_currentPos);
                  });
                },
                height: widget.height ?? 480.h,
                enableInfiniteScroll: false),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return _children[index];
            },
          ),
          // (widget.isEnabledCell) ? Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: _children.map((url) {
          //     int index = _children.indexOf(url);
          //     return Container(
          //       width: 12.w,
          //       height: 12.w,
          //       margin: EdgeInsets.only(top: 8.w, left: 4.w, right: 4.w),
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: _currentPos == index ? AppColors.indicatorSelectColor : AppColors.indicatorUnSelect,
          //       ),
          //     );
          //   }).toList(),
          // ) : const SizedBox( height: 0, width: 0,),
        ]),
      ),
    );
  }
}

// class SliderImageView extends StatelessWidget {
//   String imgPath;
//
//   SliderImageView({super.key, required this.imgPath});
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//         clipBehavior: Clip.hardEdge,
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24.w),
//           color: Colors.blue,
//         ),
//         width: 375.w,
//         height: 480.w,
//         child: FittedBox(
//           fit: BoxFit.fill,
//           child: Image.network(imgPath),
//         ));
//   }
// }
