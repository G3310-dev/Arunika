import 'package:arunika/Page/disabilitas.dart';
import 'package:flutter/material.dart';

import '../Page/undead.dart';

class Routing {
  static Route<dynamic> generateRoute(RouteSettings Route){

    switch (Route.name){
      case "/" :
        return MaterialPageRoute(builder: (_) => Undead());
      case "/disabilitas" :
        return MaterialPageRoute(builder: (_) => Disabilitas());
      default :
        return MaterialPageRoute(builder: (_) => const Undead());
    }
  }
}