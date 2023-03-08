import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/text_info.dart';
import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

class FormTextField extends StatefulWidget {
  final String? value;
  final Function()? onTap;
  final ValueChanged? onChange;
  final int maxLines;
  final Decoration?decoration;
  final double padding;
  final String? hintText;
  final bool showTextForm;
  final ValueChanged<TextInfo>? onPress;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  const FormTextField({Key? key, this.value, this.onTap, this.onChange, this.maxLines = 1, this.decoration, this.padding = 12, this.hintText, this.showTextForm = false, this.onPress, this.textStyle, this.textAlign}) : super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late TextEditingController _controller;

  late TextInfo _textInfo;
  String? value;

  @override
  void initState() {
    value = widget.value ?? '';
    _controller = TextEditingController(text: value??'');
    _textInfo = TextInfo();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormTextField oldWidget) {
    if(widget.value != value && oldWidget.value != widget.value){
      _controller.text = widget.value!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.showTextForm) {
      return Container(
        decoration: widget.decoration,
        padding: EdgeInsets.all(widget.padding),
        child: TextFormField(
          controller: _controller,
          onTap: widget.onTap,
          onChanged: (val){
            value = val;
            _textInfo = TextInfo(text: val);
            if(widget.onPress != null){
              widget.onPress!(_textInfo);
            }
            if(widget.onChange != null){
              widget.onChange!(val);
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText??'',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(
                left: 14.0, bottom: 6.0, top: 8.0),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(color: Colors.red),
            //   borderRadius: BorderRadius.circular(10.0),
            // ),
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          maxLines: widget.maxLines,
        ),
      );
    }

    return TextEditor(
      fonts: const ['OpenSans',
        'Billabong',
        'GrandHotel',
        'Oswald',
        'Quicksand',
        'BeautifulPeople',
        'BeautyMountains',
        'BiteChocolate',
        'BlackberryJam',
        'BunchBlossoms',
        'CinderelaRegular',
        'Countryside',
        'Halimun',
        'LemonJelly',
        'QuiteMagicalRegular',
        'Tomatoes',
        'TropicalAsianDemoRegular',
        'VeganStyle',],
      text: value??'',
      textStyle: widget.textStyle??const TextStyle(fontSize: 20, color: Colors.white),
      textAlingment: widget.textAlign,
      minFontSize: 8,
      maxFontSize: 40,

      onEditCompleted: (style, align, text) {
        value = text;
        _textInfo = TextInfo(text: text,textStyle: style,textAlign: align,positionLeft: Get.width/2.5,positionTop: 150);
        if(widget.onPress != null){
          widget.onPress?.call(_textInfo);
        }
        Navigator.pop(context);
      },

    );
  }
}
