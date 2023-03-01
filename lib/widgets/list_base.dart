import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/helper/device.dart';
import 'package:ai_ecard/import.dart';
import 'package:flutter/material.dart';

class ListBase extends StatelessWidget {
  final List? items;
  final Function(Map item)? detailBuilder;
  final bool shrinkWrap;
  final Map<DeviceSize, int> ? response;
  const ListBase(
      {Key? key, this.items, this.detailBuilder, this.shrinkWrap = true,
        this.response
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
      shrinkWrap: shrinkWrap,
      itemCount: length,
      itemBuilder: (context, index) {
        return _detailBuilder(context,items!,index,row);
      },
      separatorBuilder: (context, index) {
        return const SizedBox();
      },
    );
    return list;
  }

  Widget _detailBuilder(BuildContext context, List items, int index, int row){

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
        list.add(Expanded(child: detailBuilder!(items.elementAt(iElement))));
      }
      if(y<row-1){
        list.add(const SizedBox());
      }
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
