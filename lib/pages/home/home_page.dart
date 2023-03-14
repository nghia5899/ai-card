import 'package:ai_ecard/global.dart';
import 'package:ai_ecard/helper/device.dart';
import 'package:ai_ecard/pages/home/home_controller.dart';
import 'package:ai_ecard/routers.dart';
import 'package:ai_ecard/widgets/form_text_field.dart';
import 'package:ai_ecard/widgets/list_base.dart';
import 'package:ai_ecard/widgets/svg_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 224,
                      ),
                      const Text(
                        'Browse by category',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xff1B514A)),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: ListBase(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 5).copyWith(top: 10),
                          response: const {DeviceType.phone: 2},
                          items: controller.items,
                          // isWrap: true,
                          separatorWidget: const SizedBox(
                            width: 20,
                            height: 30,
                          ),
                          detailBuilder: (item) {
                            return InkWell(
                              onTap: (){
                                Get.toNamed(AppRoutes.homeDetail,arguments: item);
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
                                          color: item['color'],
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
                                      child: Image.asset('${item['image']}'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(item['title'],style: TextStyle(color: Theme.of(context).cardColor,fontWeight: FontWeight.w600,fontSize: 14),textAlign: TextAlign.center),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(16)),
                      color: Color(0xff1B514A)),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10,),
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
                        padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                    const SizedBox(width: 12,height: 12,child: SvgViewer(url: 'assets/icons/ic_search.svg',fit: BoxFit.cover,color: Colors.white,)),
                                    const SizedBox(width: 3,),
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
        );
      },
    );
  }
}
