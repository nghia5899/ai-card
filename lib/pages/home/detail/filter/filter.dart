import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/models/template/template_model.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/widgets/button_base.dart';
import 'package:ai_ecard/widgets/select_dropdown.dart';
import 'package:ai_ecard/widgets/svg_viewer.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

class HomeDetailFilter extends StatelessWidget {
  final Map? params;
  final ValueChanged? onChange;

  const HomeDetailFilter({Key? key, this.onChange, this.params})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeDetailFilterController>(
      init: HomeDetailFilterController(params: params ?? {}),
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SafeArea(
            bottom: true,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 48,
                    height: 6,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Flexible(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 17),
                              child: Text(
                                'Filter',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          const Divider(
                            height: 1,
                            color: Color(0xffE2E8F0),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                  children: [
                                    if(false)
                                    _GroupItem(
                                      label: 'Sort by',
                                      child: FormSelectDropDown(
                                        hintText: 'Recently Listed',
                                        value: (!empty(controller['orderBy']))
                                            ? controller['orderBy']
                                            : '',
                                        items: const {
                                          '1': 'Sort by name a-z',
                                          '2': 'sort in order',
                                          '3': 'sort by creation date',
                                        },
                                        onChanged: (val) {
                                          controller['orderBy'] = val;
                                        },
                                      ),
                                    ),

                                    _GroupItem(
                                      label: 'License',
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  controller['premium'] = '0';
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: (!empty(controller['premium']) && controller['premium'] == '0')
                                                              ? AppColors
                                                                  .primary
                                                              : const Color(
                                                                  0xffE2E8F0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Free',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff64748B)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 24,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  controller['premium'] = '1';
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: (!empty(controller['premium']) && controller['premium'] == '1')
                                                              ? AppColors
                                                                  .primary
                                                              : const Color(
                                                                  0xffE2E8F0))),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(Icons.star,
                                                          color: Colors
                                                              .amberAccent,
                                                          size: 18),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'premium',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff64748B)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    _GroupItem(
                                      label: 'Color',
                                      child: Wrap(
                                        alignment: WrapAlignment.start,
                                        children: colors.entries
                                            .map<Widget>((e) => InkWell(
                                                  onTap: () {
                                                    controller['color'] = e.key;
                                                  },
                                                  child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 19,
                                                            right: 20),
                                                    decoration: BoxDecoration(
                                                      border: (!empty(controller[
                                                                  'color']) &&
                                                              controller[
                                                                      'color'] ==
                                                                  e.key)
                                                          ? Border.all(
                                                              color: e.value,
                                                              width: 2)
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        border: (e.key ==
                                                                HashColor.c11)
                                                            ? Border.all(
                                                                color: const Color(
                                                                    0xff94A3B8),
                                                                width: 1)
                                                            : null,
                                                        color: e.value,
                                                      ),
                                                    ),
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                    _GroupItem(
                                      label: 'Orientation',
                                      child: Wrap(
                                          children: controller.orientations
                                              .map((e) => InkWell(
                                                    onTap: () {
                                                      controller[
                                                              'orientation'] = e['code'];
                                                    },
                                                    child: FractionallySizedBox(
                                                        widthFactor: 1 / 2,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16),
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color: (!empty(controller['orientation']) && controller['orientation'] == e['code'])
                                                                      ? AppColors
                                                                          .primary
                                                                      : const Color(
                                                                          0xffE2E8F0))),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SvgViewer(url: e['image']),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                '${e['title']}',
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff64748B)),
                                                              )
                                                            ],
                                                          ),
                                                        ).paddingOnly(
                                                            right: 24,
                                                            bottom: 24)),
                                                  ))
                                              .toList()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            width: Get.width,
                            padding: const EdgeInsets.all(24),
                            child: ButtonBase(
                                onPressed: () {
                                  if (onChange != null) {
                                    onChange!(controller.filters);
                                  }
                                  Get.back();
                                },
                                onHover: (val) {},
                                backgroundColor: const Color(0xff1B514A),
                                buttonStyle: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1B514A),
                                  padding: const EdgeInsets.all(17),
                                  // textStyle: const TextStyle(
                                  //     color: Colors.white, fontSize: 25, fontStyle: FontStyle.normal),
                                ),
                                child: const Text(
                                  'Apply',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GroupItem extends StatelessWidget {
  final String? label;
  final Widget child;
  const _GroupItem({Key? key, this.label, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? '',
            style: const TextStyle(
                color: Color(0xff64748B),
                fontSize: 16,
                fontWeight: FontWeight.w700)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: child,
        )
      ],
    );
  }
}

gridView(BuildContext context, {required List<Widget> items}) {
  final double width = Get.width;
  return Wrap(
      children: items
          .map((e) => FractionallySizedBox(
                widthFactor: 1 / ((width >= 768) ? 3 : 8),
                child: e,
              ))
          .toList());
}
