import 'package:ai_ecard/helper/helper.dart';
import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/models/text_info.dart';
import 'package:flutter/material.dart';
import 'controller.dart';


class ImageEditorPage extends StatefulWidget {
  const ImageEditorPage({Key? key}) : super(key: key);

  @override
  State<ImageEditorPage> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditorPage> {

  final fonts = [
    'OpenSans',
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
    'VeganStyle',
  ];

  List<TextInfo> texts = [];
  @override
  Widget build(BuildContext context) {

    List<dynamic>? images = Get.arguments?.images;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<ImageEditorController>(
        autoRemove: true,
        tag: 'images-render',
        init: ImageEditorController(images: images ?? []),
        builder: (controller) {
          texts = controller.texts;
          return SafeArea(
            // top: false,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.passthrough,
                children: [
                  // Image.asset('assets/story.png'),
                  if(!empty(controller.image))
                    Image.network(
                      controller.image[0],
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                          ),
                        );
                      },
                    )
                  else
                    Container(
                      width: Get.width,
                      height: Get.height,
                      color: Colors.transparent,
                    ),
                  if(!empty(controller.texts))
                    for (int i = 0; i < texts.length; i++)
                      Positioned(
                        left: texts[i].positionLeft,
                        top: texts[i].positionTop,
                        child: GestureDetector(
                          onLongPress: () {},
                          onTap: () async {
                            tapHandler(
                              context,
                              text: texts[i].text,
                              textStyle: texts[i].textStyle,
                              onChange: (obj) {
                                if (empty(obj.text)) {
                                  controller.texts.removeAt(i);
                                } else {
                                  texts[i].text = obj.text;
                                  texts[i].textStyle = obj.textStyle;
                                  texts[i].textStyle = obj.textStyle;
                                }
                                controller.update();
                              },
                            );
                          },
                          child: Draggable(
                            feedback: ImageText(textInfo: texts[i]),
                            childWhenDragging: const SizedBox(),
                            onDragEnd: (drag) {
                              final renderBox =
                              context.findRenderObject() as RenderBox;
                              Offset off = renderBox.globalToLocal(drag.offset);
                              setState(() {
                                texts[i].positionTop = off.dy;
                                texts[i].positionLeft = off.dx;
                              });
                            },
                            child: ImageText(textInfo: texts[i]),

                          ),
                        ),
                      ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        tapHandler(
                          context,
                          onChange: (obj) {
                            if (!empty(obj.text)) {
                              controller.texts.add(obj);
                            }
                            controller.update();
                            print('${controller.texts}');
                          },
                        );
                      },
                      icon: const Icon(Icons.text_fields),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageText extends StatelessWidget {
  final TextInfo textInfo;
  const ImageText({
    Key? key,
    required this.textInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Text(
        textInfo.text??'',
        textAlign: textInfo.textAlign,
        style: textInfo.textStyle ?? TextStyle(
          color: textInfo.color,
          fontSize: textInfo.fontSize,
          fontWeight: textInfo.fontWeight,
          fontFamily: textInfo.fontFamily
        ),
        // style: TextStyle(
        //   fontSize: textInfo.fontSize,
        //   fontWeight: textInfo.fontWeight,
        //   fontStyle: textInfo.fontStyle,
        //   color: textInfo.color,
        // ),
      ),
    );
  }
}




