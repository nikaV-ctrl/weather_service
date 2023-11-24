import 'package:flutter/material.dart';

class ColumnSpace extends StatelessWidget {
  final double value;

  const ColumnSpace(this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(height: value);
}