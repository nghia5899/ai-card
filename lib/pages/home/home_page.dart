import 'package:ai_ecard/global.dart';
import 'package:ai_ecard/helper/device.dart';
import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/models/category/category_model.dart';
import 'package:ai_ecard/pages/home/home_controller.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/form_text_field.dart';
import 'package:ai_ecard/widgets/list_base.dart';
import 'package:ai_ecard/widgets/svg_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ScrollController? _scrollController;
  late num height = 0.0;
  ValueNotifier<int>? pixel;
  double expandedHeight = 170;

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }


  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    _scrollController!.addListener(() {
      if (_scrollController!.position.userScrollDirection ==
          ScrollDirection.reverse) {
        height = _scrollController!.offset;
        setState(() {

        });
      }
      if (_scrollController!.position.userScrollDirection ==
          ScrollDirection.forward) {
        height = _scrollController!.offset;
        setState(() {

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return CustomScrollView(
          controller: _scrollController,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: expandedHeight,
              pinned: true,
              floating: true,
              snap: true,
              title: height >= 90? Container(
                padding: const EdgeInsets.only(right: 15),
                child: Text(
                  'AI Ecard',
                  style: AppStyles.primaryButtonTitle,
                  textAlign: TextAlign.center,
                ),
              ):null,
              backgroundColor: const Color(0xff1B514A),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 24,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: FormTextField(
                              hintText: 'Search greeting card...',
                              onChange: (val) {
                                controller.updateText(val);
                              },
                              inputDecoration: inputDecoration(
                                fillColor: Theme.of(context).cardColor,
                                hintText: 'Search greeting card...',
                                // contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 0),
                                contentPadding: EdgeInsets.zero,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: SvgViewer(url: 'assets/icons/ic_search.svg',fit: BoxFit.cover),
                                ),
                              ),
                              onEditingComplete: (){
                                Get.toNamed(AppRoutes.homeDetail,arguments: {
                                  'title': controller.text,
                                  'filter': controller.text,
                                });
                              },
                              showTextForm: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ListBase(
                              padding: EdgeInsets.zero,
                              response: const {DeviceType.phone: 3},
                              items: controller.texts,
                              isWrap: true,
                              detailBuilder: (item) {
                                return InkWell(
                                  onTap: (){
                                    Get.toNamed(AppRoutes.homeDetail,arguments: item);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: const Color.fromRGBO(255, 255, 255, 0.2),),
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                    child: Wrap(
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        // const SizedBox(width: 12,height: 12,child: SvgViewer(url: 'assets/icons/ic_search.svg',fit: BoxFit.cover,color: Colors.white,)),
                                        // const SizedBox(width: 3,),
                                        Text(item['title'], style: TextStyle(
                                            color: Theme.of(context).cardColor
                                        ),),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorWidget: const SizedBox(
                                height: 12,
                                width: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Browse by category',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xff1B514A)),
                    textAlign: TextAlign.start,
                  ),
                );
              }, childCount: 1),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ListBase(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 5).copyWith(top: 10),
                  response: const {
                    DeviceType.phone: 2,
                    DeviceType.tablet: 4,
                    DeviceType.desktop: 4,
                  },
                  items: controller.items,
                  // isWrap: true,
                  separatorWidget: const SizedBox(
                    width: 20,
                    height: 30,
                  ),
                  detailBuilder: (item) {
                    final CategoryModel _item = item as CategoryModel;
                    return InkWell(
                      onTap: (){
                        greetings = !empty(_item.greetings)? _item.greetings!.split(','): [];
                        Get.toNamed(AppRoutes.homeDetail,arguments: _item.toJson());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Transform.rotate(
                              angle: 0.2,
                              origin: const Offset(0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: borderRadius,
                                    // color: item['color'],
                                    color: _item.color
                                ),
                                height: 170.0,
                                width: 133.0,
                              ),
                            ),
                            Container(
                              decoration:  BoxDecoration(
                                borderRadius: borderRadius,
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromRGBO(0, 0, 0, 0),
                                      Color.fromRGBO(0, 0, 0, 0.3),
                                    ]),
                              ),
                              // child: Image.asset('${item['image']}'),
                              child: Image.asset('${_item.image}'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child: Text(item['title'],style: TextStyle(color: Theme.of(context).cardColor,fontWeight: FontWeight.w600,fontSize: 14),textAlign: TextAlign.center),
                              child: Text(item.title??'',style: TextStyle(color: Theme.of(context).cardColor,fontWeight: FontWeight.w600,fontSize: 14),textAlign: TextAlign.center),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                );
              }, childCount: 1),
            ),
          ],
        );
      },
    );
  }
}

