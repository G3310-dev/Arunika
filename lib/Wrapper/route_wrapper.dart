import 'package:arunika/Page/add_obat.dart';
import 'package:arunika/Page/kesehatan.dart';
import 'package:arunika/Page/Authentication/sign_in.dart';
import 'package:arunika/Page/Authentication/sign_up.dart';
import 'package:arunika/Page/disabilitas.dart';
import 'package:arunika/Page/home.dart';
import 'package:arunika/Page/obat.dart';
import 'package:arunika/Page/pola_hidup.dart';
import 'package:arunika/Page/settings.dart';
import 'package:flutter/material.dart';

import '../Page/bantuan.dart';
import '../Page/konsultasi.dart';
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
      case "/kesehatan" :
        return MaterialPageRoute(builder: (_) => Kesehatan());
      case "/obat" :
        return MaterialPageRoute(builder: (_) => Obat() );
      case "/konsultasi" :
        return MaterialPageRoute(builder: (_) => Konsultasi() );
      case "/disabilitas" :
        return MaterialPageRoute(builder: (_) => Disabilitas());
      case "/addObat" :
        return MaterialPageRoute(builder: (_) => AddObat());
      case "/profil" :
        return MaterialPageRoute(builder: (_) => Settings());
      case "/bantuan" :
        return MaterialPageRoute(builder: (_) => Bantuan());
      default :
        return MaterialPageRoute(builder: (_) => const Undead());
    }
  }
}