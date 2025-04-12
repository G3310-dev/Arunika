import 'package:arunika/Page/get_started.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Page/home.dart';
import 'Wrapper/auth_wrapper.dart';
import 'Wrapper/route_wrapper.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  runApp(MyApp(cameras: cameras,));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required List<CameraDescription> cameras});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthWrap>(
          create: (_) => AuthWrap(FirebaseAuth.instance),
        ),
        StreamProvider<User?>(
          create: (context) => context.read<AuthWrap>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
          useMaterial3: true,
        ),
        onGenerateRoute: Routing.generateRoute,
        home: AuthenticationWrapper(camera: availableCameras()),
      ),
    );
  }
}


class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key, required Future<List<CameraDescription>> camera});

  @override
  Widget build(BuildContext context) {
    final firebaseUser  = context.watch<User?>();

    if (firebaseUser  != null) {
      return Home();
    } else {
      return GetStarted(camera: availableCameras());
    }
  }
}
