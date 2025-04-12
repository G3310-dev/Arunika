import 'package:flutter/material.dart';
import '../Component/text_model.dart';

class Undead extends StatelessWidget {
  const Undead({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextWidget(size: 40.0, content: "404", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
              const TextWidget(size: 20.0, content: "The page you're looking for is not found", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
