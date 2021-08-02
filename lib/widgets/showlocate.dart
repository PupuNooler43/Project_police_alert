import 'package:flutter/material.dart';

class ShowLocate extends StatelessWidget {
  final String locate;
  final TextStyle textStyle;
  const ShowLocate({ Key? key, required this.locate, required this.textStyle }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      locate,
      style: textStyle,);
  }
}