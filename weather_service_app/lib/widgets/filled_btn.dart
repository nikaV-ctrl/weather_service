import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {
  final double height;
  final double? width;
  final Color backgroundColor;
  final double radius;
  final Function? onPressed;
  final String text;
  final TextStyle textStyle;
  final TextAlign? textAlign;
  const FilledButtonWidget({
    super.key,
    required this.height,
    this.width,
    required this.backgroundColor,
    required this.radius,
    required this.onPressed,
    required this.text,
    required this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                radius,
              ),
            ),
          ),
        ),
        onPressed: () {
          onPressed != null ? onPressed!() : null;
        },
        child: Text(
          text,
          textAlign: textAlign,
          style: textStyle,
        ),
      ),
    );
  }
}
