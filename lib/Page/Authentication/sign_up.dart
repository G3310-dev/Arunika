import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../Component/button.dart';
import '../../Component/image_button.dart';
import '../../Component/orline.dart';
import '../../Component/text_field.dart';
import '../../Component/text_model.dart';
import '../../Wrapper/auth_wrapper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUnState();
}

class _SignUnState extends State<SignUp> {
  @override
  void initState() {
    if(FirebaseAuth.instance.currentUser != null){
      Navigator.pushNamed(context, "/");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmpasswordController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height*0.05),
              Container(
                margin: EdgeInsets.only(bottom: 5, left: 10),
                child: Image.asset("asset/icon/sun.png",
                  width: 45,
                  height: 45,
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextWidget(size: 40.0, content: "Kamu Baru Ya?", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
                const TextWidget(size: 19.0, content: "Selamat datang di Arunika", type: 0, colour: 0xFF364D63, alignment: TextAlign.center),
                const SizedBox(height: 30,),
                ImageButton(
                    width: MediaQuery.sizeOf(context).width*0.85,
                    height:  50,
                    type: 2,
                    onTap: (){
                      context.read<AuthWrap>().signInWithGoogle(context: context);
                      if(FirebaseAuth.instance.currentUser != null){
                        Navigator.pushNamed(context, "/");
                      }
                    },
                    text: "Masuk Dengan Google",
                    size: 18,
                    icon: 'asset/icon/google.svg'),
                const SizedBox(height: 30,),
                SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.8,
                    child: const OrLine()
                ),
                const SizedBox(height: 30,),

                FieldText(text: "Email", height: 50, desc: 'Email', obs: false, control: emailController, textType: 2,),
                const SizedBox(height: 10,),
                FieldText(text: "Kata Sandi", height: 50, desc: 'Password', obs: false, control: passwordController, textType: 2,),
                const SizedBox(height: 10,),
                FieldText(text: "Konfirmasi Kata Sandi", height: 50, desc: 'Password', obs: false, control: confirmpasswordController, textType: 2,),
                const SizedBox(height: 50,),
                ButtonDef(
                  width: MediaQuery.sizeOf(context).width*0.85,
                  height: MediaQuery.sizeOf(context).height*0.05,
                  type: 1,
                  onTap: ()  {
                    context.read<AuthWrap>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      confirm: confirmpasswordController.text.trim(),
                      context: context,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Wait..."),
                      duration: Duration(milliseconds: 700),
                    ));
                    if(FirebaseAuth.instance.currentUser != null){
                      Navigator.pushNamed(context, "/");
                    }

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Wait..."),
                      duration: Duration(milliseconds: 700),
                    ));
                    Navigator.pushReplacementNamed(context, "/");
                  },
                  text: "Daftar",
                  size: 18,
                ),
                const SizedBox(height: 7,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  },
                  child: const TextWidget(size: 13.0, content: "Sudah Ada Akun? Klik Disini!", type: 3, colour: 0xFF5285AB, alignment: TextAlign.center),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
