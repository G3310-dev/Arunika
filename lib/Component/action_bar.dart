import 'package:arunika/Component/text_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionBar extends StatefulWidget {
  const ActionBar({super.key});

  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.only(top: 35, left: 15, right: 30, bottom: 20),
      width: double.infinity,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              return Scaffold.of(context).openDrawer();
            },
            child: SvgPicture.asset("asset/icon/burger.svg",
              colorFilter: const ColorFilter.mode(Color(0xFF5285AB), BlendMode.srcIn),
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 7.0),
            child: TextWidget(size: 25.0, content: "Selamat Datang!", type: 2, colour: 0xFF5285AB, alignment: TextAlign.left),
          ),
        ],
      ),
    );
  }
}
