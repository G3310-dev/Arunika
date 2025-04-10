import 'package:flutter/material.dart';

class ButtonIconDef extends StatefulWidget {
  final double width;
  final double height;
  final int type;
  final VoidCallback onTap;
  final String text;
  final double size;
  final Icon icon;

  const ButtonIconDef({Key? key,
    required this.width,
    required this.height,
    required this.type,
    required this.onTap,
    required this.text,
    required this.size,
    required this.icon}) : super(key: key);

  @override
  State<ButtonIconDef> createState() => _ButtonIconDefState();
}

class _ButtonIconDefState extends State<ButtonIconDef> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
            color: widget.type == 1? const Color(0xFF5285AB) : Colors.transparent,
            border: Border.all(
                color: const Color(0xFF5285AB),
                width: 2.5
            )
        ),
        width: widget.width,
        height:  widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon,
            SizedBox(width: 10,),
            Text(
              widget.text,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: widget.type == 1? Colors.white : const Color(0xFF5285AB),
                  fontSize: widget.size
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
