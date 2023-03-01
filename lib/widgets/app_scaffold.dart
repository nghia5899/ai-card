import 'package:ai_ecard/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  final bool? resizeToAvoidBottomInset;
  final Widget? body;
  final String? title;
  final PreferredSizeWidget? appBar;
  const AppScaffold({Key? key, this.resizeToAvoidBottomInset, this.body, this.title, this.appBar}) : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset ?? false,
      appBar: widget.appBar ?? CustomAppBar(),
      body: widget.body
    );
  }

}

AppBar customAppBar(){
  return AppBar();
}
