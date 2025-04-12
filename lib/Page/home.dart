import 'package:arunika/Component/action_bar.dart';
import 'package:arunika/main.dart';
import 'package:flutter/material.dart';

import '../Component/drawer.dart';
import '../Component/text_model.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerDef(),
      key: _scaffoldKey,
      body: Column(
        children: [
          ActionBar(),
          Center(
            child: Container(
                width: MediaQuery.sizeOf(context).width*0.87,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                        image: AssetImage("asset/image/item1.png"),
                        fit: BoxFit.cover
                    )
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 23, right: 14, bottom: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 90,
                        height: 17,
                        decoration: const BoxDecoration(
                            color: Colors.white
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextWidget(size: 24.0, content: "Kesehatan anda adalah  yang terpenting!", type: 2, colour: 0xFFFFFFFF, alignment: TextAlign.start),
                    ],
                  ),
                )
            ),
          ),
          Column(
            children: [
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 35),
                  child: TextWidget(size: 23.0, content: "Untuk Anda", type: 2, colour: 0xFF5285AB, alignment: TextAlign.left)
              ),
              SizedBox(height: 5,),
              SizedBox(
                width: MediaQuery.sizeOf(context).width*0.87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width*0.42,
                      height: MediaQuery.of(context).size.height*0.18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(
                          image: AssetImage("asset/image/item2.png"),
                          fit: BoxFit.cover
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("asset/icon/icontem2.png",
                            width: 80,
                            height: 80,
                          ),
                          TextWidget(size: 19.0, content: "Kesehatan Anda", type: 2, colour: 0xFFFFFFFF, alignment: TextAlign.start),
                        ],
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, "/pola"),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width*0.42,
                            height: MediaQuery.of(context).size.height*0.085,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                  image: AssetImage("asset/image/item3.png"),
                                  fit: BoxFit.cover
                              ),
                            ),
                            child: TextWidget(size: 19.0, content: "Pola Hidup", type: 2, colour: 0xFFFFFFFF, alignment: TextAlign.start),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.42,
                          height: MediaQuery.of(context).size.height*0.085,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                                image: AssetImage("asset/image/item4.png"),
                                fit: BoxFit.cover
                            ),
                          ),
                          child: TextWidget(size: 19.0, content: "Obat Anda", type: 2, colour: 0xFFFFFFFF, alignment: TextAlign.start),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 35),
                  child: TextWidget(size: 23.0, content: "Untuk Anda", type: 2, colour: 0xFF5285AB, alignment: TextAlign.left)
              ),
              SizedBox(height: 5,),
              SizedBox(
                width: MediaQuery.sizeOf(context).width*0.87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.42,
                          height: MediaQuery.of(context).size.height*0.085,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                                image: AssetImage("asset/image/item5.png"),
                                fit: BoxFit.cover
                            ),
                          ),
                          child: TextWidget(size: 19.0, content: "Konsultasi", type: 2, colour: 0xFFFFFFFF, alignment: TextAlign.start),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width*0.42,
                          height: MediaQuery.of(context).size.height*0.085,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: const DecorationImage(
                                image: AssetImage("asset/image/item6.png"),
                                fit: BoxFit.cover
                            ),
                          ),
                          child: TextWidget(size: 19.0, content: "Bantuan Lanjut", type: 2, colour: 0xFFFFFFFF, alignment: TextAlign.start),
                        ),
                      ],
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/disabilitas"),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width*0.42,
                        height: MediaQuery.of(context).size.height*0.18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                              image: AssetImage("asset/image/item7.png"),
                              fit: BoxFit.cover
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("asset/icon/icontem1.png",
                              width: 80,
                              height: 80,
                            ),
                            TextWidget(size: 17.0, content: "Layanan Disabilitas", type: 2, colour: 0xFFFFFFFF, alignment: TextAlign.start),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ]
      ),
    );
  }
}
