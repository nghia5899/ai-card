import 'dart:math';
import 'package:ai_ecard/helper/file_helper.dart';
import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/pages/home/detail/controller.dart';
import 'package:ai_ecard/pages/image_editor/page.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/widgets/button_base.dart';
import 'package:ai_ecard/widgets/form_text_field.dart';
import 'package:ai_ecard/widgets/svg_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'filter/filter.dart';

class HomeDetailPage extends StatefulWidget {
  final Map? filters;

  const HomeDetailPage({Key? key, this.filters}) : super(key: key);

  @override
  State<HomeDetailPage> createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  Map? params;

  @override
  void initState() {
    if (Get.arguments is Map) {
      params = Get.arguments ?? '';
    } else {
      params = widget.filters ?? {};
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeDetailController>(
      // tag: 'home-detail-${!empty(widget.filters) &&  !empty(widget.filters!['filter'])?widget.filters!['filter']:''}',
      init: HomeDetailController(),
      builder: (controller) {
        return Scaffold(
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
            title: Text('${params!['title'] ?? ''}', style: const TextStyle(color: Colors.black)),
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
                    const HomeDetailFilter(),
                  );
                },
                icon: const SvgViewer(url: 'assets/icons/ic_filter.svg'),
              ),
            ],
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              if (empty(widget.filters))
                Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: controller.texts
                        .map((e) => InkWell(
                              onTap: () async {
                                await controller.selectAll(type: e);
                                Get.to(HomeDetailPage(
                                  filters: {'title': e, 'code': e},
                                ));
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    // border: Border.all(width: 1),
                                    color: const Color(0xffE0E3DE),
                                  ),
                                  child: Center(
                                      child: Text(e,
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500,
                                          )))).marginOnly(
                                right: 20,
                              ),
                            ))
                        .toList(),
                  ),
                ),
              const SizedBox(
                height: 15,
              ),
              if (!empty(controller.listSelectAll))
                Expanded(
                  child: StaggeredGridView.count(
                    crossAxisCount: 4,
                    // I only need two card horizontally
                    padding: const EdgeInsets.all(20).copyWith(top: 0),
                    staggeredTiles:
                        controller.listSelectAll.map<StaggeredTile>((_) => const StaggeredTile.fit(2)).toList(),
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    children: controller.listSelectAll.map<Widget>((item) {
                      // final int randomNumber = Random().nextInt(3);
                      return GestureDetector(
                          onTap: () async {
                            showLoading();
                            Uint8List image = await FileHelper.createImage(Image.asset(item['image']));
                            List<TextInfo> clone = [];
                            for (int i = 0; i < controller.listText.length; i++) {
                              TextInfo item = controller.listText[i];
                              clone.add(controller.listText[i].copyWith(textStyle: null, color: item.color, fontSize: item.fontSize, fontFamily: item.fontFamily, fontWeight: item.fontWeight));
                            }
                            disableLoading();
                            Get.toNamed(
                              AppRoutes.edit,
                              arguments: EditObject(
                                image,
                                clone,
                              ),
                            );
                          },
                          child: IntrinsicWidth(
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xffA2D1EB),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      if (!empty(item['image'])) Image.asset(item['image'], fit: BoxFit.cover),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        child: Text(
                                          '${item['title']}',
                                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await controller.bookMark(item['code'], reLoad: true);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: const Color.fromRGBO(0, 0, 0, 0.6),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.all(6),
                                    child: SvgViewer(
                                      url: 'assets/icons/ic_star.svg',
                                      color: controller.checkBookMark(item['code']) ? null : Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 100,
                                  left: 25,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: controller.listText
                                        .map<Widget>(
                                          (e) => ImageText(textInfo: e),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                          ));
                    }).toList(), // add some space
                  ),
                )
              else
                const Expanded(
                    child: Center(
                  child: Text('No Data !!!'),
                ))
            ],
          ),
        );
      },
    );
  }
}

class EditObject {
  Uint8List image;
  List<TextInfo> textInfo;

  EditObject(this.image, this.textInfo);
}
