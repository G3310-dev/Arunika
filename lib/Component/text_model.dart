import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final size;
  final content;
  final type;
  final colour;
  final alignment;

  const TextWidget({super.key,
    required this.size,
    required this.content,
    required this.type,
    required this.colour,
    required this.alignment
  });

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.content,
      style: TextStyle(
          fontWeight: widget.type == 1? FontWeight.w500 : widget.type == 2? FontWeight.w800 : FontWeight.normal,
          fontSize: widget.size,
          color: Color(widget.colour)
      ),
      textAlign: widget.alignment,
    );
  }
}
