import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Component/button.dart';
import '../Component/drawer.dart';
import '../Component/text_model.dart';

class Bantuan extends StatelessWidget {
  Bantuan({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerDef(),
      key: _scaffoldKey,
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
                TextWidget(size: 25.0, content: "Bantuan Lanjut", type: 2, colour: 0xFF5285AB, alignment: TextAlign.left,)
              ],
            ),
          ),
          SizedBox(height: 10,),
          const Spacer(),
          Column(
            children: [
              Icon(Icons.call_merge_outlined, size: 90, color: Color(0xFF5285AB),),
              const TextWidget(size: 40.0, content: "Perlu bantuan?", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
              const SizedBox(height: 5,),
              TextWidget(size: 20.0, content: 'Jangan khawatir', type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
              TextWidget(size: 15.0, content: 'Hubungi pengembang untuk bantuan lanjut', type: 1, colour: 0xFF5285AB, alignment: TextAlign.center),
              const SizedBox(height: 50,),
              const SizedBox(height: 3,),
              Center(
                child: ButtonDef(
                    width: MediaQuery.sizeOf(context).width*0.5,
                    height: MediaQuery.sizeOf(context).height*0.04,
                    type: 2,
                    onTap: () async{
                      try {
                        await launchUrl(Uri.parse('https://wa.me/081282600092'));
                      } catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString().trim()),
                          duration: const Duration(seconds: 2),
                        ));
                      }
                    },
                    text: "Hubungi Pengembang", size: 16),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}