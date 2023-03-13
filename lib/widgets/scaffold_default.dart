import 'package:ai_ecard/pages/archive/page.dart';
import 'package:ai_ecard/pages/home/home_page.dart';
import 'package:ai_ecard/pages/menu/page.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:ai_ecard/widgets/svg_viewer.dart';
import 'package:flutter/material.dart';

class ScaffoldDefault extends StatefulWidget {
  const ScaffoldDefault({Key? key}) : super(key: key);

  @override
  State<ScaffoldDefault> createState() => _ScaffoldDefaultState();
}

class _ScaffoldDefaultState extends State<ScaffoldDefault> {

  int _index = 0;

   final List<Map> _contents = [
    {
      'title': 'Home',
      'icon': 'assets/icons/ic_home.svg',
      'iconOutlined': 'assets/icons/ic_home_outlined.svg',
      'child': const HomePage()
    },
    {
      'title': 'Archive',
      'icon': 'assets/icons/ic_bookmark.svg',
      'iconOutlined': 'assets/icons/ic_bookmark_outlined.svg',
      'child': const ArchivePage()
    },
    {
      'title': 'More',
      'icon': 'assets/icons/ic_more.svg',
      'iconOutlined': 'assets/icons/ic_more_outlined.svg',
      'child': const MenuPage()
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _contents[_index]['child'],
      bottomNavigationBar: BottomNavigationBar(
        items: _itemsBottom,
        onTap: _onItemTappedTabBottom,
        currentIndex: _index,
        selectedIconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
        selectedItemColor: AppColors.primaryColor,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      )
    );
  }

  _onItemTappedTabBottom(index){
    setState(() {
      _index = index;
    });
  }

  List<BottomNavigationBarItem> get _itemsBottom{
    return List.generate(_contents.length, (i) => BottomNavigationBarItem(
        icon: SvgViewer(url: (i == _index)?_contents[i]['iconOutlined']:_contents[i]['icon'],color: i == _index? AppColors.primaryColor: null),
        label: _contents[i]['title'],

    )).toList();
  }


}
