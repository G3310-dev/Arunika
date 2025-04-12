import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageButton extends StatefulWidget {
  final double width;
  final double height;
  final int type;
  final String icon;
  final VoidCallback onTap;
  final String text;
  final double size;

  const ImageButton({Key? key,
    required this.width,
    required this.height,
    required this.type,
    required this.onTap,
    required this.icon,
    required this.text,
    required this.size}) : super(key: key);

  @override
  State<ImageButton> createState() => _ButtonDefState();
}

class _ButtonDefState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTap();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: widget.type == 1? const Color(0xFFD1D1D1) : Colors.transparent,
            border: Border.all(
                color: const Color(0xFFD1D1D1),
                width: widget.type == 1? 0 : 2.5
            )
        ),
        width: widget.width,
        height:  widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(widget.icon, width: widget.size+7, height: widget.size+7,),
            const SizedBox(width: 10,),
            Text(
              widget.text,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: widget.type == 1? Colors.white : const Color(0XFF7A7A7A),
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
