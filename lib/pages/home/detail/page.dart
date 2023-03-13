import 'dart:math';
import 'package:ai_ecard/helper/file_helper.dart';
import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/pages/home/detail/controller.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/widgets/form_text_field.dart';
import 'package:ai_ecard/widgets/svg_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'filter/filter.dart';

class HomeDetailPage extends StatefulWidget {
  const HomeDetailPage({Key? key}) : super(key: key);

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeDetailController>(
      init: HomeDetailController(),
      builder: (controller) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            elevation: 0.1,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.keyboard_backspace_outlined,
                color: Colors.black,
              ),
            ),
            title: const Text('Wedding',
                style: TextStyle(
                  color: Colors.black,
                )),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                        enableDrag: true,
                        persistent: true,
                        ignoreSafeArea: false,
                        isDismissible: true,
                        isScrollControlled: true,
                        HomeDetailFilter()
                    );
                  },
                  icon: const SvgViewer(url: 'assets/icons/ic_filter.svg'))
            ],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.only(left: 20),
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: controller.texts
                      .map((e) => Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 11, horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                // border: Border.all(width: 1),
                                color: const Color(0xffE0E3DE),
                              ),
                              child: Center(
                                  child: Text(e,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12))))
                          .marginOnly(right: 20))
                      .toList(),
                ),
              ),
              Expanded(
                child: StaggeredGridView.count(
                  crossAxisCount: 4, // I only need two card horizontally
                  padding: const EdgeInsets.all(20),

                  //Here is the place that we are getting flexible/ dynamic card for various images
                  staggeredTiles: controller.items
                      .map<StaggeredTile>((_) => const StaggeredTile.fit(2))
                      .toList(),
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  children: controller.items.map<Widget>((item) {
                    final int randomNumber = Random().nextInt(3);
                    return GestureDetector(
                      onTap: () async{
                        Uint8List image = await FileHelper.createImage(Image.asset(item['image'][randomNumber]));
                        Get.toNamed(AppRoutes.export, arguments: image);
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if(!empty(item['image'])) Image.asset(item['image'][randomNumber],fit: BoxFit.cover),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12
                              ),
                              child: Text('${item['title']}',style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                              ),),
                            ),

                          ],
                        ),
                      ),
                    );
                  }).toList(), // add some space
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
