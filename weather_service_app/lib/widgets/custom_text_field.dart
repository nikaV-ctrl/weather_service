import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final double? height;
  final TextEditingController? textController;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Color? fillColor;
  const CustomTextField({
    super.key,
    this.hintText,
    this.textController,
    this.inputFormatters,
    this.keyboardType,
    this.height,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height ?? 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: fillColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: TextFormField(
                inputFormatters: inputFormatters,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: textController,
                decoration: InputDecoration(
                  hintText: hintText ?? '',
                  fillColor: fillColor,
                  border: InputBorder.none,
                  isDense: true,
                ),
                keyboardType: keyboardType ?? TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
