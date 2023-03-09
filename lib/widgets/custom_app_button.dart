import 'package:ai_ecard/styles/app_color.dart';
import 'package:flutter/material.dart';

class CustomAppButton extends StatefulWidget {
  final Function()? onPressed;
  final String title;
  Color? textColor;
  Color? borderColor;
  BorderRadius? borderRadius;
  CustomAppButton({Key? key, required this.title, this.onPressed, this.borderColor}) : super(key: key);

  @override
  State<CustomAppButton> createState() => _CustomAppButtonState();
}

class _CustomAppButtonState extends State<CustomAppButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: widget.borderRadius ?? BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.red, width: 2)
                )
            ),
          minimumSize: MaterialStateProperty.all<Size>(
            const Size(double.infinity, 50)
          )
        ),
        child: Center(
          child: Text(
              widget.title
          ),
        ),
    );
  }
}
