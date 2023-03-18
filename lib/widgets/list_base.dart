import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/helper/device.dart';
import 'package:ai_ecard/import.dart';
import 'package:flutter/material.dart';

class ListBase extends StatelessWidget {
  final List? items;
  final Function(dynamic item)? detailBuilder;
  final Function(dynamic item)? detailBuilderLast;
  final bool shrinkWrap;
  final Map<DeviceSize, int> ? response;
  final EdgeInsets? padding;
  final Widget? separatorWidget;
  final bool isWrap;
  final ScrollPhysics? physics;
  final Widget Function(List<Widget>)? builderRowLast;
  const ListBase(
      {Key? key, this.items,
        this.detailBuilder,
        this.detailBuilderLast,
        this.shrinkWrap = true,
        this.response,
        this.padding,
        this.separatorWidget,
        this.physics,
        this.builderRowLast,
        this.isWrap = false
      }
      ) : super(key: key);

  int get length{
    List? items = this.items;
    int row = _checkRow(response);
    int number = (!empty(items!))?(items.length / row).ceil():1;

    return number;
  }

  int _checkRow(Map<DeviceSize, int>? size){
    int row = 1;
    if(!empty(size)){
      size!.forEach((key, value) {
        final double minW = key.minWidth??0;
        final double maxW = key.maxWidth??double.infinity;
        if(Get.width >= minW && maxW >= Get.width){
          row = value;
        }
      });
    }
    return row;
  }


  @override
  Widget build(BuildContext context) {
    List? items = this.items;
    int row = _checkRow(response);
    Widget list =  ListView.separated(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics?? const ScrollPhysics(),
      itemCount: length,
      itemBuilder: (context, index) {
        return _detailBuilder(context,items!,index,row,col: length);
      },
      separatorBuilder: (context, index) {
        return separatorWidget??const SizedBox();
      },
    );
    return list;
  }

  Widget _detailBuilder(BuildContext context, List items, int index, int row, {int ? col}){

    List<Widget> list = [];
    int length = items.length;
    int i = index;
    int iElement = 0;

    if(row == 1){
      return detailBuilder!(items.elementAt(index));
    }
    for(int y=0;y<row;y++){
      iElement = i * row +y;
      if(iElement <= length - 1){
        if(isWrap){
          list.add(detailBuilder!(items.elementAt(iElement)));
        }else if((items.length % 2 != 0) && detailBuilderLast != null && (col == i +1) ){
          list.add(detailBuilderLast!(items.elementAt(iElement)));
        }else{
          list.add(Expanded(child: detailBuilder!(items.elementAt(iElement))));
        }
      }

      if(y<row-1){
        list.add(separatorWidget??const SizedBox());
      }
    }

    if(isWrap){
      return Theme(
        data: ThemeData(),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: list,
        ),

      );
    }

    if(items.length % 2 != 0 && detailBuilderLast != null && (col == i +1)){
      if(builderRowLast != null){
        return builderRowLast!(list);
      }
      return Theme(
        data: ThemeData(),
        child: Row(
          children: list,
        ),

      );
    }
    return Theme(
      data: ThemeData(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),

    );
  }
}
