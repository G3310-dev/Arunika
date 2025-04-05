import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';
import '../Component/bounding_box.dart';

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

  void toggleCamera() {
    CameraDescription newDescription;
    newDescription = cameras.firstWhere(
          (description) => description.lensDirection == CameraLensDirection.back,
    );
    initializeCamera(newDescription);
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
    } // Debug print

    setState(() {
      this.recognitions = recognitions;
      imageHeight = image.height; // Update image height
      imageWidth = image.width; // Update image width
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(title: Text('Real-time Object Detection')),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
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
        ],
      ),
    );
  }
}
