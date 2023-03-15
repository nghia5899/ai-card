import 'package:ai_ecard/models/text_info.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditTextDialog extends StatefulWidget {
  TextInfo textInfo;
  void Function(String)? onChanged;
  void Function(String)? done;
  EditTextDialog({Key? key, required this.textInfo, this.onChanged, this.done}) : super(key: key);

  @override
  State<EditTextDialog> createState() => _EditTextDialogState();
}

class _EditTextDialogState extends State<EditTextDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.text = widget.textInfo.text ?? '';
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.done?.call(_textEditingController.text);
        Get.back();
      },
      child: AppScaffold(
        backGroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: TextFormField(
              controller: _textEditingController,
              onChanged: widget.onChanged,
              minLines: 1,
              maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.w),
                        ),
                        borderSide: BorderSide(color: Colors.white24)),
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.white24,
                    filled: true),
            ),
          ),
        ),
      ),
    );
  }
}
