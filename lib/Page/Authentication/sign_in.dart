import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Component/button.dart';
import '../../Component/image_button.dart';
import '../../Component/orline.dart';
import '../../Component/text_field.dart';
import '../../Component/text_model.dart';
import '../../Wrapper/auth_wrapper.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                const TextWidget(size: 40.0, content: "Halo Sobat!", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
                const TextWidget(size: 19.0, content: "Selamat datang di Arunika", type: 0, colour: 0xFF364D63, alignment: TextAlign.center),
                const SizedBox(height: 30,),
                ImageButton(
                    width: MediaQuery.sizeOf(context).width*0.85,
                    height:  50,
                    type: 2,
                    onTap: () async {
                      try{
                        await  context.read<AuthWrap>().signInWithGoogle(context: context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Wait..."),
                          duration: Duration(milliseconds: 700),
                        ));
                        if(FirebaseAuth.instance.currentUser != null){
                          Navigator.pushNamed(context, "/");
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Auth Failed"),
                            duration: Duration(milliseconds: 700),
                          ));
                        }
                      }catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString().trim()),
                          duration: const Duration(milliseconds: 700),
                        ));
                      }
                    },
                    text: "Masuk dengan Google",
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
                FieldText(text: "Kata Sandi", height: 50, desc: 'Password', obs: true, control: passwordController, textType: 2,),
                const SizedBox(height: 50,),
                ButtonDef(
                  width: MediaQuery.sizeOf(context).width*0.85,
                  height: MediaQuery.sizeOf(context).height*0.05,
                  type: 1,
                  onTap: () async {
                    try {
                      await context.read<AuthWrap>().signIn(
                        context: context,
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Wait..."),
                        duration: Duration(milliseconds: 700),
                      ));
                      Navigator.popAndPushNamed(context, "/");
                    } catch(e){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e.toString().trim()),
                        duration: const Duration(milliseconds: 700),
                      ));
                    }
                  },
                  text: "Masuk",
                  size: 18,
                ),
                const SizedBox(height: 7,),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/logup");
                  },
                  child: const TextWidget(size: 13.0, content: "Tidak punya Akun? Klik Disini!", type: 3, colour: 0xFF5285AB, alignment: TextAlign.center),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
