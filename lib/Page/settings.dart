import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Component/action_bar.dart';
import '../Component/button.dart';
import '../Component/drawer.dart';
import '../Component/text_model.dart';
import '../Wrapper/auth_wrapper.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      drawer: const DrawerDef(),
      key: _scaffoldKey,
      body: Column(
        children: [
          ActionBar(),
          SizedBox(height: 10,),
          const Spacer(),
          Column(
            children: [
              Icon(Icons.people_rounded, size: 90, color: Color(0xFF5285AB),),
              const TextWidget(size: 40.0, content: "Halo Sobat!", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
              const SizedBox(height: 20,),
              TextWidget(size: 20.0, content: user?.email, type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
              TextWidget(size: 15.0, content: user?.uid, type: 1, colour: 0xFF5285AB, alignment: TextAlign.center),
              const SizedBox(height: 50,),
              const SizedBox(height: 3,),
              Center(
                child: ButtonDef(
                    width: MediaQuery.sizeOf(context).width*0.5,
                    height: MediaQuery.sizeOf(context).height*0.04,
                    type: 2,
                    onTap: () async{
                      try {
                        await context.read<AuthWrap>().signOut();
                        Navigator.pushReplacementNamed(context, "/");
                      } catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString().trim()),
                          duration: const Duration(milliseconds: 700),
                        ));
                      }
                    },
                    text: "Ganti Akun", size: 16),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}