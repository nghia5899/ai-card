import 'package:ai_ecard/pages/home/home_page.dart';
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
      'child': const HomePage()
    },
    {
      'title': 'Archive',
      'icon': 'assets/icons/ic_bookmark.svg',
      'child': Text('2')
    },
    {
      'title': 'More',
      'icon': 'assets/icons/ic_more.svg',
      'child': Text('1')
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
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold
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
        icon: SvgViewer(url: _contents[i]['icon'],),
        label: _contents[i]['title'],

    )).toList();
  }


}
