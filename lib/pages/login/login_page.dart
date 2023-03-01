import 'package:ai_ecard/pages/login/login_controller.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController>{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Text('hello_world'.tr),
      ),
    );
  }

}