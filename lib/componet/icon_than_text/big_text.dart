import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String textBody;
  Color? color;
  double? size;
  double? height;
  TextOverflow textOverflow;
  BigText(
      {Key? key,
      required this.textBody,
      this.color = const Color(0xFF332d2b),
      this.textOverflow = TextOverflow.ellipsis,
        this.height=1.2,
      this.size=20})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      textBody,
      maxLines: 1,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: size,
        height: height,
        fontWeight: FontWeight.w400,
        color: color,
      ),
      overflow: textOverflow,
    );
  }
}
