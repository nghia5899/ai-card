import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/pages/export/export_controller.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ImageViewsPage extends StatefulWidget {

  const ImageViewsPage({Key? key}) : super(key: key);

  @override
  State<ImageViewsPage> createState() => _ImageViewsPageState();
}

class _ImageViewsPageState extends State<ImageViewsPage> {
  late PageController pageController;

  int index = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final List images = Get.arguments ?? [];

    return Scaffold(
      backgroundColor: const Color(0xff1E293B),
      appBar: AppBar(
        backgroundColor:const Color(0xff1E293B),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.close_outlined, color: Colors.white),
        ),
        elevation: 0.1,
        centerTitle: true,
        title: Wrap(
          children: List.generate(images.length, (i) => Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: (index == i)?Colors.white: const Color.fromRGBO(84, 113, 173, 0.4),
            ),
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(right: 8),
          )),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: (){
        //
        //     },
        //     icon: const Icon(Icons.update, color: Colors.white),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
              margin: const EdgeInsets.all(24.0),
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
                children: images.map<Widget>((e) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      e['image_url'],
                      fit: BoxFit.fitWidth,
                      width: 500,
                      height: 500,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return LoadingAnimationWidget.threeRotatingDots(
                          color: const Color(0xff94A3B8),
                          size: 35,
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.all(24.0),
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextButton(
              onPressed: (){
                if(Get.isRegistered<ExportController>()) {
                  ExportController exportController = Get.find();
                  exportController.image.value = images[index]['image_url'];
                }
              },
              child: const Text('Apply to card'),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
