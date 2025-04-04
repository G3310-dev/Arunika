import 'package:arunika/Page/disabilitas.dart';
import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/material.dart';

import '../Component/button.dart';
import '../Component/orline.dart';
import '../Component/text_model.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key, required Future<List<CameraDescription>> camera});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height*0.05),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5, left: 5),
                          child: Image.asset("asset/icon/sun.png",
                            width: 45,
                            height: 45,
                          ),
                        ),
                        SizedBox(width: 10,),
                        TextWidget(size: 30.0, content: "Arunika", type: 2, colour: 0xFF5285AB, alignment: TextAlign.left)
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height*0.45,
                      decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage("asset/image/started.png",),
                            fit: BoxFit.fill,
                            alignment: Alignment.topCenter,
                          )
                      ),
                    )
                  ],
                )
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 27.0, right: 30.0, top: 20.0, bottom: MediaQuery.sizeOf(context).height*0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    size: 30.0,
                    content: "Selamat datang di",
                    type: 1,
                    colour: 0xFF5285AB,
                    alignment: TextAlign.left,),
                  const TextWidget(
                    size: 37.0,
                    content: "Arunika!",
                    type: 2,
                    colour: 0xFF5285AB,
                    alignment: TextAlign.left,),
                  const SizedBox(height: 10,),
                  const TextWidget(
                      size: 19.0,
                      content: "Arunika! Bersama Kita Jaga, Rawat, dan Lestarikan Kehidupan untuk Masa Depan yang Lebih Cerah",
                      type: 1,
                      colour: 0xFF5285AB,
                      alignment: TextAlign.left),
                  SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
                  Center(
                    child: ButtonDef(
                        width: MediaQuery.sizeOf(context).width*0.9,
                        height: MediaQuery.sizeOf(context).height*0.04,
                        type: 1,
                        onTap: (){
                          Navigator.pushNamed(context, "/signIn");
                        },
                        text: "Yuk Mulai!", size: 15),
                  ),
                  const SizedBox(height: 3,),
                  const OrLine(),
                  const SizedBox(height: 3,),
                  Center(
                    child: ButtonDef(
                        width: MediaQuery.sizeOf(context).width*0.9,
                        height: MediaQuery.sizeOf(context).height*0.05,
                        type: 2,
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const Disabilitas()),
                          );
                        },
                        text: "Layanan Disabilitas", size: 16),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
