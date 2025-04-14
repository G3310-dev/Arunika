import 'package:arunika/Component/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../Component/text_model.dart';

class Kesehatan extends StatefulWidget {
  const Kesehatan({super.key});

  @override
  State<Kesehatan> createState() => _KesehatanState();
}

class _KesehatanState extends State<Kesehatan> {
  final TextEditingController _chatController = TextEditingController();
  final List<Map<String, dynamic>> _chatHistory = [];
  late final GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(model: 'gemini-2.0-flash',
        apiKey: 'AIzaSyB4pu0Ll_P2IQej15RumbUsYBE8B-dSdJk');
    setState(() {
      _chatHistory.add({
        "message": "Selamat datang sobat!, Aku adalah sobat AI yang akan membantu konsultasi kesehatanmu, Apakah ada rasa kurang nyaman pada dirimu?, Boleh kok kamu konsul disini, ceritakan saja ya",
        "isSender": false,
      });
    });
  }

  void _sendMessage() async {
    final response = await _model.generateContent([Content.text("Anda adalah seorang dokter dengan pengalaman bekerja sekitar 30 tahun lebih. Pasien anda berkata seperti ini ${_chatController.text}. Tolong jawab dan berikan pertanyaan/permintaan pasien.  WARNING: LANGSUNG BERIKAN RESPON, TIDAK PERLU MENYEBUT BAHWA ANDA ADALAH DOKTER DENGAN PEGALAMAN 30 TAHUN, JANGAN MASUKAN FORMAT TEKS APAPUN(BOLD, UNDERLINE, ITALIC)")]);

    if (_chatController.text.isNotEmpty) {
      setState(() {
        _chatHistory.add({
          "message": _chatController.text,
          "isSender": true,
        });
        _chatController.clear();
      });
      setState(() {
        _chatHistory.add({
          "message": response.text,
          "isSender": false,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height*0.01,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 30,
                      color: Color(0xFF5285AB),
                    ),
                  ),
                  const SizedBox(width: 10),
                  TextWidget(
                    size: 25.0,
                    content: "Kesehatan Anda",
                    type: 2,
                    colour: 0xFF5285AB,
                    alignment: TextAlign.left,
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: _chatHistory.length,
                itemBuilder: (context, index) {
                  final chat = _chatHistory[index];
                  return Align(
                    alignment: chat["isSender"]
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: chat["isSender"]
                            ? Color(0xFF5285AB)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x40000000),
                            blurRadius: 7.0,
                          ),
                        ],
                      ),
                      child: Text(
                        chat["message"],
                        style: TextStyle(
                          color: chat["isSender"]
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10 + MediaQuery.of(context).viewInsets.bottom*0.01),
              decoration: BoxDecoration(
                color: Color(0xFFfff4fc),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: FieldText(
                      text: "Apa yang kamu rasa? (pusing, dll)",
                      height: 50,
                      desc: "Konsultasi",
                      textType: 1,
                      obs: false,
                      control: _chatController,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, size: 30),
                    onPressed: _sendMessage,
                    color: Color(0xFF5285AB),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}