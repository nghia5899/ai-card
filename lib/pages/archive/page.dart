import 'dart:math';
import 'package:ai_ecard/helper/file_helper.dart';
import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'controller.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  State<ArchivePage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ArchiveController>(
      init: ArchiveController(),
      builder: (controller) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Theme.of(context).cardColor,
            automaticallyImplyLeading: false,
            elevation: 0.1,
            title: const Text('Archive', style: TextStyle(color: Colors.black)),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Builder(
                  builder: (_) {
                    if(controller.items == null){
                      return const CircularProgressIndicator();
                    }
                    if(!empty(controller.items)){
                      return Expanded(
                        child: StaggeredGridView.count(
                          crossAxisCount: 4, // I only need two card horizontally
                          padding: const EdgeInsets.all(20).copyWith(top: 0),
                          staggeredTiles: controller.items!
                              .map<StaggeredTile>((_) => const StaggeredTile.fit(2))
                              .toList(),
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                          children: controller.items!.map<Widget>((item) {
                            // final int randomNumber = Random().nextInt(3);
                            return GestureDetector(
                                onTap: () async{
                                  Uint8List image = await FileHelper.createImage(Image.asset(item['image']));
                                  Get.toNamed(AppRoutes.export, arguments: image);
                                },
                                child: IntrinsicWidth(
                                  child: Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: const Color(0xffA2D1EB),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            if (!empty(item['image']))
                                              Image.asset(item['image'],
                                                  fit: BoxFit.cover),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              child: Text(
                                                '${item['title']}',
                                                style: const TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async{
                                          await controller.bookMark(item['code'],reLoad: true);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color:  Colors.red,
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          margin: const EdgeInsets.all(6),
                                          child: const Icon(Icons.delete_outline,color: Colors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            );
                          }).toList(), // add some space
                        ),
                      );
                    }
                    return const Expanded(child: Center(child: Text('No data !!!'),));
                  },
              ),

            ],
          ),
        );
      },
    );
  }
}
