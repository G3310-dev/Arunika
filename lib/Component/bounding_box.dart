import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class BoundingBoxes extends StatefulWidget {
  final List<dynamic> recognitions;
  final double previewH;
  final double previewW;
  final double screenH;
  final double screenW;

  const BoundingBoxes({super.key,
    required this.recognitions,
    required this.previewH,
    required this.previewW,
    required this.screenH,
    required this.screenW,
  });

  @override
  _BoundingBoxesState createState() => _BoundingBoxesState();
}

class _BoundingBoxesState extends State<BoundingBoxes> {
  late FlutterTts flutterTts;
  String lastSpokenClass = "";

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    _speakLargestObject();
  }

  String getDirection(double centerX, double centerY) {
    if (centerX < widget.screenW / 2 && centerY < widget.screenH / 2) {
      return "Kiri Atas";
    } else if (centerX >= widget.screenW / 2 && centerY < widget.screenH / 2) {
      return "Kanan Atas";
    } else if (centerX < widget.screenW / 2 && centerY >= widget.screenH / 2) {
      return "Kiri Bawah";
    } else {
      return "Kanan Bawah";
    }
  }

  Future<void> _speakLargestObject() async {
    while (true) {
      if (widget.recognitions.isNotEmpty) {
        var largestObject = widget.recognitions.reduce((a, b) =>
        a["confidenceInClass"] > b["confidenceInClass"] ? a : b);
        String detectedClass = largestObject["detectedClass"];

        double x = largestObject["rect"]["x"] * widget.screenW;
        double y = largestObject["rect"]["y"] * widget.screenH;
        double w = largestObject["rect"]["w"] * widget.screenW;
        double h = largestObject["rect"]["h"] * widget.screenH;
        double centerX = x + (w / 2);
        double centerY = y + (h / 2);
        String direction = getDirection(centerX, centerY);

        if (detectedClass != lastSpokenClass) {
          await flutterTts.setLanguage("id-ID");
          await flutterTts.setVoice({"name": "Karen", "locale": "id-ID"});
          await flutterTts.setPitch(1.0);
          await flutterTts.speak("Di $direction anda ada $detectedClass");
          lastSpokenClass = detectedClass;

          await Future.delayed(Duration(seconds: 3));
        }
      }

      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: widget.recognitions.map((rec) {
        var x = rec["rect"]["x"] * widget.screenW;
        var y = rec["rect"]["y"] * widget.screenH;
        double w = rec["rect"]["w"] * widget.screenW;
        double h = rec["rect"]["h"] * widget.screenH;

        return Positioned(
          left: x,
          top: y,
          width: w,
          height: h,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 3,
              ),
            ),
            child: Text(
              "${rec["detectedClass"]} ${(rec["confidenceInClass"] * 100).toStringAsFixed(0)}% Width:${(w).ceil()} Height: ${h.ceil()}",
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                background: Paint()..color = Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}