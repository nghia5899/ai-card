// import 'package:flutter_animate/flutter_animate.dart';
//
// import '../import.dart';
//
// class AnimationMoveCard extends StatefulWidget {
//   double width;
//   double height;
//   double begin;
//   double end;
//   Widget child;
//   AnimationMoveCard({Key? key, required this.width, required this.height, required this.child, required this.begin, required this.end}) : super(key: key);
//
//   @override
//   State<AnimationMoveCard> createState() => _AnimationMoveCardState();
// }
//
// class _AnimationMoveCardState extends State<AnimationMoveCard> with TickerProviderStateMixin{
//   late AnimationController controller;
//   @override
//   void initState() {
//     controller = AnimationController(vsync: this);
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return widget.child.animate(controller: controller).scaleXY(alignment: Alignment.centerRight, begin: widget.begin, end: widget.end, duration: 1000.ms);
//   }
// }
