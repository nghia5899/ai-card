import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Folding Cell Widget
class FoldingCard extends StatefulWidget {
  const FoldingCard(
      {Key? key,
      required this.frontWidget,
      required this.innerWidget,
      this.cellSize = const Size(100.0, 100.0),
      this.unfoldCell = false,
      this.skipAnimation = false,
      this.padding = const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
      this.animationDuration = const Duration(milliseconds: 500),
      this.borderRadius = 0.0,
      this.onBinding,
      this.onOpen,
      this.onClose})
      : assert(frontWidget != null),
        assert(cellSize != null),
        assert(unfoldCell != null),
        assert(skipAnimation != null),
        assert(padding != null),
        assert(animationDuration != null),
        assert(borderRadius != null && borderRadius >= 0.0),
        assert(innerWidget != null),
        super(key: key);

  const FoldingCard.create(
      {Key? key,
      required this.frontWidget,
      required this.innerWidget,
      this.cellSize = const Size(100.0, 100.0),
      this.unfoldCell = false,
      this.skipAnimation = false,
      this.padding = const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
      this.animationDuration = const Duration(milliseconds: 500),
      this.borderRadius = 0.0,
      this.onBinding,
      this.onOpen,
      this.onClose})
      : assert(frontWidget != null),
        assert(innerWidget != null),
        assert(cellSize != null),
        assert(unfoldCell != null),
        assert(skipAnimation != null),
        assert(padding != null),
        assert(animationDuration != null),
        assert(borderRadius != null && borderRadius >= 0.0),
        super(key: key);

  // Front widget in folded cell
  final Widget? frontWidget;

  final Function()? onBinding;

  /// Inner widget in unfolded cell
  final Widget? innerWidget;

  /// Size of cell
  final Size cellSize;

  /// If true cell will be unfolded when created, if false cell will be folded when created
  final bool unfoldCell;

  /// If true cell will fold and unfold without animation, if false cell folding and unfolding will be animated
  final bool skipAnimation;

  /// Padding around cell
  final EdgeInsetsGeometry padding;

  /// Animation duration
  final Duration animationDuration;

  /// Rounded border radius
  final double borderRadius;

  /// Called when cell fold animations completes
  final VoidCallback? onOpen;

  /// Called when cell unfold animations completes
  final VoidCallback? onClose;

  @override
  FoldingCardState createState() => FoldingCardState();
}

class FoldingCardState extends State<FoldingCard> with SingleTickerProviderStateMixin {
  late bool _isExpanded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      widget.onBinding?.call();
    });
    super.initState();
    _animationController = AnimationController(vsync: this, duration: widget.animationDuration);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.onOpen != null) widget.onOpen!();
      } else if (status == AnimationStatus.dismissed) {
        if (widget.onClose != null) widget.onClose!();
      }
    });

    if (widget.unfoldCell) {
      _animationController.value = 1;
      _isExpanded = true;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final angle = _animationController.value * pi;
          final cellWidth = widget.cellSize.width;
          final cellHeight = widget.cellSize.height;

          return Padding(
            padding: widget.padding,
            child: Container(
              color: Colors.transparent,
              // width: cellWidth,
              // height: cellHeight + (cellHeight * _animationController.value),
              width: cellWidth + (cellWidth * _animationController.value),
              height: cellHeight,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(widget.borderRadius),
                        topRight: Radius.circular(widget.borderRadius)),
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                          width: cellWidth,
                          height: cellHeight,
                          child: widget.innerWidget != null
                              ? OverflowBox(
                            minWidth: cellWidth,
                            maxWidth: cellWidth * 2,
                            alignment: Alignment.centerRight,
                            child: ClipRect(
                              child: Align(
                                widthFactor: 0.5,
                                alignment: Alignment.centerRight,
                                child: widget.innerWidget,
                              ),
                            ),
                          )
                              : widget.innerWidget,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(pi),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(widget.borderRadius),
                                bottomRight: Radius.circular(widget.borderRadius)),
                            child: Container(
                              width: cellWidth,
                              height: cellHeight,
                              child: widget.innerWidget != null
                                  ? OverflowBox(
                                minWidth: cellWidth,
                                maxWidth: cellWidth * 2,
                                alignment: Alignment.centerLeft,
                                child: ClipRect(
                                  child: Align(
                                    widthFactor: 0.5,
                                    alignment: Alignment.centerLeft,
                                    child: widget.innerWidget,
                                  ),
                                ),
                              )
                                  : widget.innerWidget,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle),
                        child: Opacity(
                          opacity: angle >= 1.5708 ? 0.0 : 1.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(widget.borderRadius),
                                topRight: Radius.circular(widget.borderRadius)),
                            child: Container(
                              width: angle >= 1.5708 ? 0.0 : cellWidth,
                              height: angle >= 1.5708 ? 0.0 : cellHeight,
                              child: widget.frontWidget,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void toggleFold() {
    if (_isExpanded) {
      if (widget.skipAnimation) {
        _animationController.value = 0;
      } else {
        _animationController.reverse();
      }
    } else {
      if (widget.skipAnimation) {
        _animationController.value = 1;
      } else {
        _animationController.forward();
      }
    }
    _isExpanded = !_isExpanded;
  }
}
