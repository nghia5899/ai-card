import 'package:flutter/material.dart';

class ButtonBase extends StatelessWidget {
  final Function()? onPressed;
  final bool isOutline;
  final Function(bool)? onHover;
  final Function(bool)? onFocusChange;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final Widget child;
  final ButtonStyle? buttonStyle;
  final double? width;
  final double? height;
  final VoidCallback? onLongPress;
  final double? elevation;
  const ButtonBase({Key? key,this.elevation, this.onPressed, this.backgroundColor, this.onFocusChange, this.onLongPress,this.isOutline = true, this.onHover, this.textColor, this.borderColor, required this.child, this.buttonStyle, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: isOutline?
      OutlinedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: buttonStyle??OutlinedButton.styleFrom(
            backgroundColor: backgroundColor??Theme.of(context).textTheme.bodyMedium!.color,
            elevation: elevation
        ),
        child: child,
      ):
      ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: buttonStyle??ElevatedButton.styleFrom(
            backgroundColor: backgroundColor??Theme.of(context).textTheme.bodyMedium!.color,
            elevation: elevation

        ),
        onFocusChange: onFocusChange,
        onHover: onHover,
        child: child,
      ),

    );
  }
}
