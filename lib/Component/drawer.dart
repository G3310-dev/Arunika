import 'package:arunika/Component/text_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerDef extends StatefulWidget {
  const DrawerDef({super.key});

  @override
  State<DrawerDef> createState() => _DrawerDefState();
}

class _DrawerDefState extends State<DrawerDef> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20,),
              width: 100,
              height: 100,
              child: Image.asset("asset/icon/sun2.png")
            ),
            TextWidget(size: 20.0, content: user?.email ?? "No Email presents", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
            const SizedBox(height: 5,),
            const SizedBox(height: 30,),
            const Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1.5,
              height: 5.0,
              color: Color(0x807A7A7A),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                var route = ModalRoute.of(context);

                if(route?.settings.name != "/"){
                  Navigator.pushReplacementNamed(context, "/");
                  Scaffold.of(context).closeDrawer();
                }else{
                  Scaffold.of(context).closeDrawer();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home_rounded,
                    color: Color(0xFF5285AB),
                  ),
                  SizedBox(width: 10,),
                  TextWidget(size: 20.0, content: "Beranda", type: 1, colour: 0xFF5285AB, alignment: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            const Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1.5,
              height: 5.0,
              color: Color(0x807A7A7A),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () async{
                var route = ModalRoute.of(context);

                if(route?.settings.name != "/profil"){
                  Navigator.pushReplacementNamed(context, "/profil");
                  Scaffold.of(context).closeDrawer();
                }else{
                  Scaffold.of(context).closeDrawer();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_rounded,
                    color: Color(0xFF5285AB),
                  ),
                  SizedBox(width: 10,),
                  TextWidget(size: 20.0, content: "Profil", type: 1, colour: 0xFF5285AB, alignment: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            const Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1.5,
              height: 5.0,
              color: Color(0x807A7A7A),
            ),
          ],
        ),
      ),
    );
  }
}
