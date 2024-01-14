import 'package:flutter/material.dart';


class VerticalText extends StatefulWidget {
  final String text;
  final Color color;
  const VerticalText({
    required this.text,
    required this.color,
    super.key});

  @override
  State<VerticalText> createState() => _VerticalTextState();
}

class _VerticalTextState extends State<VerticalText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(int i = 0; i<widget.text.length;i++)
          Text(widget.text[i], style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: widget.color),)
      ],
    );
  }
}
