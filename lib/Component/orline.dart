import 'package:flutter/material.dart';

class OrLine extends StatelessWidget {
  const OrLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0)
              ),
              child: const Divider(
                indent: 10,
                endIndent: 10,
                thickness: 1.0,
                height: 5.0,
                color: Color(0x807A7A7A),
              ),
            ),
          ),
          const Text('atau', style: TextStyle(color: Color(0xFF7A7A7A)),),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0)
              ),
              child: const Divider(
                indent: 10,
                endIndent: 10,
                thickness: 1.0,
                height: 5.0,
                color: Color(0x807A7A7A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
