import 'package:ai_ecard/styles/app_color.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderPageView extends StatefulWidget {
  const SliderPageView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SliderPageViewState();
  }
}

class _SliderPageViewState extends State<SliderPageView> {
  int currentPos = 0;
  List<String> listPaths = [
    "https://images.unsplash.com/photo-1566438480900-0609be27a4be?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80",
    "https://burst.shopifycdn.com/photos/cn-tower-sunset.jpg?width=925&exif=1&iptc=1",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWo4W6cuv62ScH_vJv5Zg_me06XGje56TJZ3JVYkyLw1wznWdjkFJI-rRkW9Oe17iVNsE&usqp=CAU",
    "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80",
    "https://images.unsplash.com/photo-1588733103629-b77afe0425ce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE0fHx8ZW58MHx8fHw%3D&w=1000&q=80",
    "https://c8.alamy.com/comp/KHRTMN/cn-tower-of-toronto-canada-lake-ontario-north-america-KHRTMN.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackGroundColor,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CarouselSlider.builder(
            itemCount: listPaths.length,
            options: CarouselOptions(
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPos = index;
                  });
                },
                height: 480.h,
                enableInfiniteScroll: false),
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return SliderImageView(imgPath: listPaths[index]);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listPaths.map((url) {
              int index = listPaths.indexOf(url);
              return Container(
                width: 12.w,
                height: 12.w,
                margin: EdgeInsets.symmetric(vertical: 16.w, horizontal: 4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPos == index ? AppColors.indicatorSelectColor : AppColors.indicatorUnSelect,
                ),
              );
            }).toList(),
          ),
        ]),
      ),
    );
  }
}

class SliderImageView extends StatelessWidget {
  String imgPath;

  SliderImageView({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.w),
          color: Colors.blue,
        ),
        width: 375.w,
        height: 480.w,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.network(imgPath),
        ));
  }
}
