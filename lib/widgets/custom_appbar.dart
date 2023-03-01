import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('hello');
  }

  @override
  Size get preferredSize => Size(100, 100);

}