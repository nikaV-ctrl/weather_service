import 'package:flutter/material.dart';

class RowSpace extends StatelessWidget {
  final double value;

  const RowSpace(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(width: value);
}