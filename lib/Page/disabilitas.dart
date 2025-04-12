import 'package:arunika/Component/icon_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../Component/bounding_box.dart';
import '../Component/text_model.dart';

class Disabilitas extends StatefulWidget {
  const Disabilitas({super.key});

  @override
  State<Disabilitas> createState() => _DisabilitasState();
}

class _DisabilitasState extends State<Disabilitas> {
  late CameraController _controller;
  bool isModelLoaded = false;
  List<dynamic>? recognitions;
  int imageHeight = 0;
  int imageWidth = 0;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    initializeCameras();
  }

  Future<void> initializeCameras() async {
    cameras = await availableCameras();
    loadModel();
    initializeCamera(cameras[0]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: 'asset/tensor/detect.tflite',
      labels: 'asset/tensor/labelmap.txt',
    );
    setState(() {
      isModelLoaded = res != null;
    });
  }

  void initializeCamera(CameraDescription description) async {
    _controller = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller.initialize();
      if (!mounted) return;

      _controller.startImageStream((CameraImage image) {
        if (isModelLoaded) {
          runModel(image);
        }
      });
      setState(() {});
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing camera: $e');
      }
    }
  }

  void runModel(CameraImage image) async {
    if (image.planes.isEmpty) return;

    var recognitions = await Tflite.detectObjectOnFrame(
      bytesList: image.planes.map((plane) => plane.bytes).toList(),
      model: 'SSDMobileNet',
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResultsPerClass: 1,
      threshold: 0.5,
    );

    if (kDebugMode) {
      print("Recognitions: $recognitions");
    }

    setState(() {
      this.recognitions = recognitions;
      imageHeight = image.height;
      imageWidth = image.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height*0.05),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5, left: 10),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                    size: 30,
                    weight: 50,
                    color: Color(0xFF5285AB),
                  )
                ),
                SizedBox(width: 10,),
                TextWidget(size: 25.0, content: "Layanan Tunanetra", type: 2, colour: 0xFF5285AB, alignment: TextAlign.left,)
              ],
            ),
          ),
          SizedBox(height: 10,),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.93,
            height: MediaQuery.of(context).size.height * 0.81,

            child: Stack(
              children: [
                CameraPreview(_controller),
                if (recognitions != null)
                  BoundingBoxes(
                    recognitions: recognitions!,
                    previewH: imageHeight.toDouble(),
                    previewW: imageWidth.toDouble(),
                    screenH: MediaQuery.of(context).size.height * 0.8,
                    screenW: MediaQuery.of(context).size.width,
                  ),
              ],
            ),
          ),
          Center(
            child: ButtonIconDef(
                width: MediaQuery.sizeOf(context).width*0.9,
                height: MediaQuery.sizeOf(context).height*0.05,
                type: 1,
                onTap: (){},
                icon: Icon(Icons.emergency,
                  color: Colors.white,
                  size: 30,
                ),
                text: "Layanan Lainnya", size: 19,),
          ),
        ],
      ),
    );
  }
}
