// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as img;
//
// class TestPage extends StatefulWidget {
//   TestPage({Key? key}) : super(key: key);
//
//   @override
//   _TestState createState() => _TestState();
// }
//
// class _TestState extends State<TestPage> {
//    File? _image;
//    int? _width;
//    int? _height;
//   GlobalKey key = GlobalKey();
//
//   void _initGallery() async {
//     final picker = ImagePicker();
//
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       // Get the image dimensions
//       File file = File(pickedFile.path);
//       img.Image? image = img.decodeImage(file.readAsBytesSync());
//
//       print('Image: ${image?.width} - ${image?.height}');
//
//       setState(() {
//         _image = file;
//         _width = image?.width ?? 0;
//         _height = image?.height ?? 0;
//       });
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             child: _image == null
//                 ? null
//                 : PanZoomImage(image: _image, width: _width, height: _height, key: key,),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _initGallery,
//         child: Icon(Icons.collections),
//       ),
//     );
//   }
// }
//
// class PanZoomImage extends StatefulWidget {
//   PanZoomImage({
//     required Key key,
//     this.image, this.height, this.width
//   })  : super(key: key);
//
//    File? image;
//    int? width;
//    int? height;
//
//   @override
//   _PanZoomImageState createState() => _PanZoomImageState();
// }
//
// class _PanZoomImageState extends State<PanZoomImage> {
//   final TransformationController controller = TransformationController();
//
//   double offsetX = 0.0;
//   double offsetY = 0.0;
//   double scaleX = 0.0;
//   double scaleY = 0.0;
//
//   late Uint8List finalImage;
//
//   final double size = 200.0;
//
//   Matrix4 _getZoomInfo({int? width, int? height, double? size, double? zoom}) {
//     var aspect = (width ?? 0) / (height ?? 1);
//
//     var ww = (size ?? 0) * (zoom ?? 0);
//     var hh = ww / aspect;
//
//     var offsetX = (size ?? 0 / 2) - (ww / 2);
//     var offsetY = ((size ?? 0 / aspect) / 2) - (hh / 2);
//
//     var matrix = Matrix4.identity();
//     matrix.setEntry(0, 0, zoom ?? 0);
//     matrix.setEntry(1, 1, zoom ?? 0);
//     matrix.setEntry(0, 3, offsetX);
//     matrix.setEntry(1, 3, offsetY);
//
//     return matrix;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 160,
//         ),
//         Row(
//           children: [
//             MaterialButton(
//               onPressed: () {
//                 controller.value =
//                     _getZoomInfo(width: widget.width, height: widget.height, size: size, zoom: 1.0);
//               },
//               child: Text("Reset"),
//             ),
//             MaterialButton(
//               onPressed: () {
//                 int w = widget.width ?? 0;
//                 int h = widget.height ?? 0;
//
//                 var zoom = w / h;
//                 controller.value =
//                     _getZoomInfo(width: widget.width, height: widget.height,size: size, zoom: zoom);
//               },
//               child: Text("Zoom fill"),
//             ),
//             MaterialButton(
//               onPressed: () {
//                 controller.value =
//                     _getZoomInfo(width: widget.width, height: widget.height, size: size, zoom: 2.0);
//               },
//               child: Text("Zoom 2x"),
//             ),
//             MaterialButton(
//               onPressed: () {
//                 controller.value =
//                     _getZoomInfo(width: widget.width, height: widget.height, size: size, zoom: 4.0);
//               },
//               child: Text("Zoom 4x"),
//             ),
//           ],
//         ),
//         Center(
//           child: ClipRect(
//             child: Container(
//               height: size,
//               width: size,
//               child: Stack(
//                 children: [
//                   Center(
//                     child: InteractiveViewer(
//                       transformationController: controller,
//                       panEnabled: true,
//                       boundaryMargin: EdgeInsets.all(200),
//                       minScale: 1.5,
//                       maxScale: 4,
//                       onInteractionStart: (ScaleStartDetails details) {
//                         // print('ScaleStart: $details');
//                       },
//                       onInteractionUpdate: (ScaleUpdateDetails details) {
//                         Matrix4 matrix = controller.value;
//                         offsetX = matrix.entry(0, 3);
//                         offsetY = matrix.entry(1, 3);
//                         scaleX = matrix.entry(0, 0);
//                         scaleY = matrix.entry(1, 1);
//
//                         // print(
//                         // " - offsetX: $offsetX, offsetY: $offsetY, scaleX: $scaleX, scaleY: $scaleY");
//                       },
//                       onInteractionEnd: (ScaleEndDetails details) {
//                         // print('ScaleEnd: $details');
//                       },
//                       child: Image.file(
//                         widget.image ?? File(''),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   IgnorePointer(
//                     child: ClipPath(
//                       clipper: InvertedCircleClipper(),
//                       child: Container(
//                         color: Color.fromRGBO(0, 0, 0, 0.5),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         MaterialButton(
//           onPressed: () {
//             int w = widget.width ?? 0;
//             int h = widget.height ?? 0;
//             var aspect = (w / h);
//             print("--------------------------");
//             print(
//                 "Crop the original image: ($w & $h), asspect: $aspect to a (360 * 360) square");
//
//             // Get scale and offsets
//             Matrix4 matrix = controller.value;
//             offsetX = matrix.entry(0, 3);
//             offsetY = matrix.entry(1, 3);
//             scaleX = matrix.entry(0, 0);
//             scaleY = matrix.entry(1, 1);
//
//             print(
//                 " - Zoomed: offsetX: $offsetX, offsetY: $offsetY, scaleX: $scaleX, scaleY: $scaleY");
//
//             // Calculate, x, y, width and height of the new image
//             var zoom = scaleX; // Ignore scaleY (scaleX == scaleY)
//
//             var x = (-1 * offsetX);
//
//             var aspectOffsetY = (size - (size / aspect)) / 2;
//             var y = (-1 * offsetY) - aspectOffsetY;
//
//             print(" - Crop: x=$x, y=$y, w=$size, h=$size");
//
//             // Calculate the scale factor to the original image
//             var factor = w / (size * zoom);
//             var xOrg = factor * x;
//             var yOrg = factor * y;
//             var width = factor * size;
//             if (width > w) {
//               width = w.toDouble();
//             }
//             var height = factor * size;
//             if (height > h) {
//               height = h.toDouble();
//             }
//             print(" - Crop original: x=$xOrg, y=$yOrg, w=$width, h=$height");
//
//             img.Image? originalImage = img.decodeImage((widget.image ?? File('')).readAsBytesSync());
//
//             img.Image croppedImage = img.copyCrop(originalImage!, x: xOrg.toInt(),
//                 y: yOrg.toInt(), width: width.toInt(), height: height.toInt(),);
//
//             img.Image resizedImage =
//             img.copyResize(croppedImage, width: 360, height: 360);
//
//
//             setState(() {
//               finalImage = img.encodeJpg(resizedImage, quality: 50);
//             });
//
//           },
//           child: Text("Crop"),
//         ),
//         finalImage == null ? Text("Crop image to see result") : Center(
//           child: Container( width: 200, height:200,
//               child: Image.memory(finalImage)),
//         )
//
//       ],
//     );
//   }
// }
//
// class InvertedCircleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return new Path()
//       ..addOval(new Rect.fromCircle(
//           center: new Offset(size.width / 2, size.height / 2),
//           radius: size.width * 0.5))
//       ..addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height))
//       ..fillType = PathFillType.evenOdd;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Widget? child;
  late TransformationController controller;
  bool isInit = true;
  final GlobalKey<ExtendedImageEditorState> editorKey =GlobalKey<ExtendedImageEditorState>();
  @override
  void initState() {
    super.initState();
    controller = TransformationController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 500.w,
            child: ExtendedImage.network(
              'https://media.istockphoto.com/id/1322277517/photo/wild-grass-in-the-mountains-at-sunset.jpg?s=612x612&w=0&k=20&c=6mItwwFFGqKNKEAzv0mv6TaxhLN3zSE43bWmFN--J5w=',
              fit: BoxFit.contain,
              mode: ExtendedImageMode.editor,
              extendedImageEditorKey: editorKey,
              cacheRawData: true,
              initEditorConfigHandler: (state) {
                return EditorConfig(
                    maxScale: 10.0,
                  cornerSize: Size(0,0),
                  lineColor: Colors.blueAccent,
                );
              },
                // loadStateChanged: (value) {
                // print(value.extendedImageInfo?.image.height);
                //     child = value.completedWidget;
                // }
            )
          ),
        ],
      ),
    );
  }
  //
  // void abc() {
  //   var a = editorKey.currentState.
  // }
}

// import 'package:flutter/material.dart';
//
// Widget abc(){
//   return Container(
//     clipBehavior: c,
//   );
// }
