import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/pages/generate/controller.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:ai_ecard/widgets/button_base.dart';
import 'package:ai_ecard/widgets/form_text_field.dart';
import 'package:flutter/material.dart';

class GenerateEdit extends GetView<GenerateController>{
  const GenerateEdit({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: AppScaffold(
          appBar: AppBar(
            title: const Text('Prompt-builder',style: TextStyle(color: Colors.black)),
            centerTitle: true,
            elevation: 0.3,
            backgroundColor: Theme.of(context).cardColor,
          ),
          body: Column(
            children: [
              Expanded(
                child: GetBuilder<GenerateController>(
                  id: 'width-height-update',
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: const Text('Width'),
                          subtitle: Slider(
                            value: controller.currentWidth.value,
                            max:1024,
                            min:512,
                            divisions: 1024,
                            label: (controller.currentWidth.value).round().toString(),
                            onChanged: (double value) {
                              controller['width'] = value;
                              controller.currentWidth.value = value;
                              controller.update(['width-height-update']);
                            },
                          ),
                        ),ListTile(
                          title: const Text('Height'),
                          subtitle: Slider(
                            value: controller.currentHeight.value,
                            max:1024,
                            min:512,
                            divisions: 1024,
                            label: (controller.currentHeight.value).round().toString(),
                            onChanged: (double value) {
                              controller['height'] = value;
                              controller.currentHeight.value = value;
                              controller.update(['width-height-update']);
                            },
                          ),
                        ),
                        FormTextField(
                          hintText: 'Nhập mô tả',
                          maxLines: 5,
                          onChange: (val){
                            controller['prompt'] = val;
                          },
                          showTextForm: true,
                        )
                      ],
                    );
                  },
                ),
              ),
              ButtonBase(
                child: const Text('Generate image'),
                onPressed: (){
                  controller.submit();
                  print(controller.fields);
                },
                onHover: (val){

                },
              )
            ],
          ),
        ),
      ),
    );
  }

}

