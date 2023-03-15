import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/pages/image_editor/page.dart';
import 'package:flutter/material.dart';

class DraggableText extends StatefulWidget {
  TextInfo textInfo;
  DraggableText({Key? key, required this.textInfo}) : super(key: key);

  @override
  State<DraggableText> createState() => _ABCState();
}

class _ABCState extends State<DraggableText> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.textInfo.positionLeft,
      top: widget.textInfo.positionTop,
      child: GestureDetector(
        onLongPress: () {
        },
        onTap: () async{
          // tapHandler(
          //     context,text: texts[i].text,textStyle: texts[i].textStyle,onChange: (obj){
          //   if(empty(obj.text)){
          //     controller.texts.removeAt(i);
          //   }else{
          //     texts[i].text = obj.text;texts[i].textStyle = obj.textStyle; texts[i].textStyle = obj.textStyle;
          //   }
          //
          //   controller.update();
          // });

        },
        child: Draggable(
          feedback: ImageText(textInfo: widget.textInfo),
          childWhenDragging: const SizedBox(),
          onDragEnd: (drag) {
            final renderBox = context.findRenderObject() as RenderBox;
            Offset off = renderBox.globalToLocal(drag.offset);
            setState(() {
              widget.textInfo.positionLeft = (widget.textInfo.positionLeft ?? 0) + off.dx;
              widget.textInfo.positionTop = (widget.textInfo.positionTop ?? 0) + off.dy;
            });
          },
          child: ImageText(textInfo: widget.textInfo),
        ),
      ),
    );
  }
}