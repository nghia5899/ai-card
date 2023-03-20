import 'package:ai_ecard/styles/app_icon.dart';
import 'package:ai_ecard/widgets/app_scaffold.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_editor/image_editor.dart';

import '../import.dart';

class EditImage extends StatefulWidget {
  Uint8List image;
  double cropAspectRatio;
  Function(Uint8List) onCrop;

  EditImage(
      {Key? key,
      required this.image,
      required this.cropAspectRatio,
      required this.onCrop})
      : super(key: key);

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  Widget build(BuildContext context) {
    final imageWidth = Get.width - 48.w;
    final imageHeight = imageWidth / widget.cropAspectRatio;
    return AppScaffold(
      backGroundColor: Colors.black87,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 36.w, left: 24.w, right: 24.w),
            child: ExtendedImage.memory(widget.image,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.contain,
                mode: ExtendedImageMode.editor,
                extendedImageEditorKey: editorKey,
                cacheRawData: true, initEditorConfigHandler: (state) {
              return EditorConfig(
                  cornerSize: const Size(0, 0),
                  cornerColor: Colors.blueAccent,
                  maxScale: 20.0,
                  lineHeight: 2.w,
                  lineColor: Colors.blueAccent,
                  cropRectPadding: EdgeInsets.all(0.w),
                  cropAspectRatio: widget.cropAspectRatio);
            }),
          ),
          Column(
            children: [
              const Spacer(),
              Row(
                children: [
                  SizedBox(width: 24.w),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(AppIcons.iconClose,
                        width: 32.w, height: 32.w, color: Colors.white),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      try {
                        if (editorKey.currentState != null) {
                          final Rect? cropRect =
                              editorKey.currentState!.getCropRect();
                          if (cropRect != null) {
                            var data = editorKey.currentState!.rawImageData;
                            ImageEditorOption option = ImageEditorOption();
                            if (editorKey.currentState!.editAction != null) {
                              if (editorKey
                                  .currentState!.editAction!.needCrop) {
                                option.addOption(ClipOption.fromRect(cropRect));
                                Uint8List? image = (await ImageEditor.editImage(
                                  image: data,
                                  imageEditorOption: option,
                                ));
                                if (image != null) {
                                  widget.onCrop.call(image);
                                }
                              }
                            }
                          }
                        }
                        Get.back();
                      } catch (e) {
                        Get.back();
                      }
                    },
                    child: Icon(Icons.check, size: 32.w, color: Colors.white),
                  ),
                  SizedBox(width: 24.w),
                ],
              ),
              SizedBox(height: 32.w)
            ],
          )
        ],
      ),
    );
  }
}
