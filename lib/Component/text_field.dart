import 'package:flutter/material.dart';

class FieldText extends StatefulWidget {
  final String text;
  final double height;
  final String desc;
  final bool obs;
  final int textType;
  var control;

  FieldText({Key? key,
    required this.text,
    required this.height,
    required this.desc,
    required this.textType,
    required this.obs,
    required this.control}) : super(key: key);

  @override
  State<FieldText> createState() => _FieldTextState();
}

class _FieldTextState extends State<FieldText> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width*0.85,
        height: widget.height,
        padding: const EdgeInsets.only(left: 20, right: 14),
        decoration: BoxDecoration(
            border: Border.all(
                width: 2,
                color: const Color(0XFFBCBCBC)
            ),
            borderRadius: BorderRadius.circular(9)
        ),
        child: TextFormField(
          maxLines: widget.textType == 1? null : 1,
          obscureText: widget.obs,
          controller: widget.control,
          decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: widget.text,
              hintStyle: const TextStyle(
                  color: Color(0XFF7A7A7A),
                  fontWeight: FontWeight.w500
              )
          ),
        )
    );
  }
}
