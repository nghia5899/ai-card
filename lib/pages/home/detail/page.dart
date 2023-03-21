import 'package:ai_ecard/helper/file_helper.dart';
import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/edit/edit_state.dart';
import 'package:ai_ecard/models/models/template/template_model.dart';
import 'package:ai_ecard/models/edit/edit_state.dart';
import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/pages/home/detail/controller.dart';
import 'package:ai_ecard/pages/image_editor/page.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/svg_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
            title: Text('${!empty(params!['title'])? params!['title'] : 'All'}', style: const TextStyle(color: Colors.black)),
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
                    HomeDetailFilter(
                      params: controller.filters,
                      onChange: (val) async {
                        controller.filters = val;
                        await controller.prefilter(filters: val);
                    },
                    ),
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
                                controller.currentTab = e;
                                await controller.selectAll(type: e);
                                // Get.to(HomeDetailPage(
                                //   filters: {'title': e, 'code': e},
                                // ));
                              },
                              child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    // border: Border.all(width: 1),
                                    color: controller.checkTabCurrent(e)?AppColors.primary:const Color(0xffE0E3DE),
                                  ),
                                  child: Center(
                                      child: Text(e,
                                          style: TextStyle(
                                            color: controller.checkTabCurrent(e)? Colors.white:AppColors.primary,
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
              Builder(
                  builder: (context) {
                    if (!empty(controller.listSelectAll)){
                      if(controller.listSelectAll.isNotEmpty){
                        return Expanded(
                          child: StaggeredGridView.count(
                            crossAxisCount: 4,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.all(20).copyWith(top: 0),
                            staggeredTiles: controller.listSelectAll.map<StaggeredTile>((_) => const StaggeredTile.fit(2)).toList(),
                            mainAxisSpacing: 15.0,
                            crossAxisSpacing: 15.0,
                            children: controller.listSelectAll.map<Widget>((item) {
                              return GestureDetector(
                                  onTap: () async {
                                    List<TextInfo> clone = [];
                                    for (int i = 0; i < controller.listText.length; i++) {
                                      TextInfo item = controller.listText[i];
                                      clone.add(controller.listText[i].copyWith(textStyle: null, color: item.textStyle?.color, fontSize: item.fontSize, fontFamily: item.textStyle?.fontFamily, fontWeight: item.textStyle?.fontWeight));
                                    }
                                    Get.toNamed(
                                      AppRoutes.edit,
                                      arguments: CardObject(templateModel: item, textInfo: clone),
                                    );
                                  },
                                  child: IntrinsicWidth(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                color: colors[item.color] ??const Color(0xffA2D1EB),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                // crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  if (!empty(item.image)) Image.asset(item.image??'', fit: BoxFit.cover),

                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 3,
                                              left: 3,
                                              child: InkWell(
                                                onTap: () async {
                                                  await controller.bookMark(item.code??'', reLoad: true);
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
                                                    color: controller.checkBookMark(item.code??'') ? null : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 30,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: controller.listText
                                                    .map<Widget>(
                                                      (e) => ImageText(textInfo: e).paddingOnly(top: 10),
                                                )
                                                    .toList(),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          child: Text(
                                            '${item.title}',
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            }).toList(), // add some space
                          ),
                        );
                      }
                      return Expanded(
                          child: Center(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.not_interested, size: 30,color: AppColors.descriptionIconColor,),
                              const SizedBox(height: 10,),
                              Text('No data !!!',style: AppStyles.descriptionIconText),
                            ],
                          ),));
                    }
                    return Expanded(
                        child: LoadingAnimationWidget.threeRotatingDots(
                            color:const Color(0xff94A3B8),
                            size: 35
                        )
                    );

                  },
              ),
            ],
          ),
        );
      },
    );
  }
}

class CardObject {
  TemplateModel templateModel;
  List<TextInfo> textInfo;

  CardObject({required this.templateModel, required this.textInfo});

}
