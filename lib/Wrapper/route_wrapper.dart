import 'package:arunika/Page/Authentication/sign_in.dart';
import 'package:arunika/Page/Authentication/sign_up.dart';
import 'package:arunika/Page/disabilitas.dart';
import 'package:arunika/Page/home.dart';
import 'package:arunika/Page/pola_hidup.dart';
import 'package:flutter/material.dart';

import '../Page/undead.dart';

class Routing {
  static Route<dynamic> generateRoute(RouteSettings Route){

    switch (Route.name){
      case "/" :
        return MaterialPageRoute(builder: (_) => Home());
      case "/login" :
        return MaterialPageRoute(builder: (_) => SignIn());
      case "/logup" :
        return MaterialPageRoute(builder: (_) => SignUp());
      case "/pola" :
        return MaterialPageRoute(builder: (_) => PolaHidup());
      case "/disabilitas" :
        return MaterialPageRoute(builder: (_) => Disabilitas());
      default :
        return MaterialPageRoute(builder: (_) => const Undead());
    }
  }
}