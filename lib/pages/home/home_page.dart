import 'package:ai_ecard/helper/device.dart';
import 'package:ai_ecard/pages/home/home_controller.dart';
import 'package:ai_ecard/widgets/list_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
 const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListBase(
        items: controller.items,
        detailBuilder: (item) {
          return ListTile(
            title: Text(item['title']),
          );
        },
        response: const {
          DeviceType.phone: 2
        },
      ),
    );
  }
}
