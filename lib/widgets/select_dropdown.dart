
import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/styles/app_color.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class FormSelectDropDown extends StatefulWidget {
  final Map<String,dynamic>? items;
  final dynamic value;
  final String? errorText;
  final String? hintText;
  final String? description;
  final ValueChanged? onChanged;
  final ValueChanged? onTitleChanged;
  final String? searchBarHint;
  final InputDecoration? decoration;
  final bool enabled;

  const FormSelectDropDown({Key? key,
    this.items,
    this.value,
    this.errorText,
    this.hintText,
    this.description,
    this.onChanged,
    this.onTitleChanged,
    this.searchBarHint,
    this.decoration,
    this.enabled = true,
  }): super(key: key);

  @override
  State<FormSelectDropDown> createState() => _FormSelectDropDownState();
}

class _FormSelectDropDownState extends State<FormSelectDropDown> {
  _FormSelectDropDownController? controller;
  bool hasShowBottom = false;
  bool show = false;
  String labelText = '';
  String _key = '';
  final UniqueKey __key = UniqueKey();


  @override
  void initState() {
    _key = 'FormSelect-${__key.toString()}';
    super.initState();
  }

  @override
  void dispose() {
    if (hasShowBottom) {
      Get.back();
    }
    controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FormSelectDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_FormSelectDropDownController>(
      init: _FormSelectDropDownController(
          value: widget.value,
          items: widget.items,
          hintText: widget.hintText
      ),
      tag: _key,
      autoRemove: true,
      builder: (controller) {
        return InkWell(
          onTap: (){
            setState(() {
              show != show;
            });
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              DropdownButtonFormField2(
                hint: Text(
                  !empty(controller.labelValue)? controller.labelValue:widget.hintText??'',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14
                  ),
                ),
                // isExpanded: true,
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                ),
                // iconStyleData: const Icon(Icons.keyboard_arrow_down_outlined),
                // dropdownDecoration: BoxDecoration(
                //   borderRadius: borderRadius,
                // ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                  border: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.border, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.border, width: 1),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.border, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: AppColors.primary, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: borderRadius,
                    borderSide: const BorderSide(color: Colors.red, width: 1),
                  ),
                  errorText: widget.errorText,
                  hintText: widget.hintText,
                ),
                selectedItemBuilder: (context) =>widget.items!.entries.toList().map((e) =>
                    DropdownMenuItem<String>(
                      value: e.key,
                      child: Text(
                        e.value,
                        style: const TextStyle(
                          fontSize: 14,
                          // color: controller.checkValue(e.key)?AppColors.primary:null
                        ),
                      ),
                    )
                ).toList(),
                // isExpanded: true,
                // buttonHeight: 50,
                // buttonPadding: const EdgeInsets.only(top: 12,right: 10,bottom: 12,left: 5),
                style: Theme.of(context).textTheme.subtitle1,
                items: widget.items!.entries.toList().map((e) =>
                    DropdownMenuItem<String>(
                      value: e.key,
                      child: Text(
                        e.value,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )
                ).toList(),
                onChanged: (value) {
                  // Get.back();
                  controller.changeValue(value);
                  _onChanged(value);
                },
                onSaved: (value) {
                },
              ),
            ],
          ),
        );
      },
    );
  }
  _onChanged(value) {
    if (widget.onChanged != null) widget.onChanged!(value);
  }
}

class _FormSelectDropDownController extends GetxController{
  final dynamic value;
  final Map<String, dynamic>? items;
  final String? hintText;

  String? _id;
  bool isCheckAll = false;
  String searchField = '';
  Function? itemsCallback;
  String labelValue = '';
  List _ids = [];

  _FormSelectDropDownController({required this.value,required this.items, this.hintText});

  @override
  void onInit() {
    if(!empty(value)){
      setValue();
      changeValue(value);
    }
    super.onInit();
  }

  bool checkValue(dynamic id) {
    return (id.toString() == _id.toString());
  }

  changeValue(dynamic id) {
    _id = id;
    getTitle();
    update();
  }

  setValue(){
    _ids = items!.keys.toList();
    if(!empty(value) && _ids.contains(value)){
      if(!empty(items![value])){
        labelValue = (items![value] is String)?items![value]:items![value]['title'];
      }
    }else{
      labelValue = hintText??'Chọn';
    }
  }

  String getTitle(){
    print('--xxx--$_id');
    if(!empty(_id)){
      labelValue = (items![_id] is String)?items![_id]:items![_id]['title'];
    }
    print('0-10000=-----$labelValue');
    return !empty(labelValue)?labelValue: hintText ??'Chọn';
  }
}


