import 'package:arunika/Page/get_started.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'Wrapper/route_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required List<CameraDescription> cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      onGenerateRoute: Routing.generateRoute,
      home: GetStarted(camera: availableCameras()),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/widgets.dart';
// import 'package:tflite_v2/tflite_v2.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   runApp(MyApp(cameras: cameras));
// }
//
// class MyApp extends StatelessWidget {
//   final List<CameraDescription> cameras;
//
//   const MyApp({Key? key, required this.cameras});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: RealTimeObjectDetection(
//         cameras: cameras,
//       ),
//     );
//   }
// }

// class RealTimeObjectDetection extends StatefulWidget {
//   final List<CameraDescription> cameras;
//
//   RealTimeObjectDetection({required this.cameras});
//
//   @override
//   _RealTimeObjectDetectionState createState() =>
//       _RealTimeObjectDetectionState();
// }
//
// class _RealTimeObjectDetectionState extends State<RealTimeObjectDetection> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_controller.value.isInitialized) {
//       return Container();
//     }
//     return Scaffold(
//       appBar: AppBar(title: Text('Real-time Object Detection')),
//       body: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.8,
//             child: Stack(
//               children: [
//                 CameraPreview(_controller),
//                 if (recognitions != null)
//                   BoundingBoxes(
//                     recognitions: recognitions!,
//                     previewH: imageHeight.toDouble(),
//                     previewW: imageWidth.toDouble(),
//                     screenH: MediaQuery.of(context).size.height * 0.8,
//                     screenW: MediaQuery.of(context).size.width,
//                   ),
//               ],
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   toggleCamera();
//                 },
//                 icon: Icon(Icons.camera_front, size: 30),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
