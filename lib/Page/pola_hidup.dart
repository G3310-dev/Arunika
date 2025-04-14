import 'package:arunika/Component/icon_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:readmore/readmore.dart';

import '../Component/button.dart';
import '../Component/text_field.dart';
import '../Component/text_model.dart';
import '../Wrapper/database_wrapper.dart';

class PolaHidup extends StatefulWidget {
  const PolaHidup({super.key});

  @override
  State<PolaHidup> createState() => _PolaHidupState();
}

class _PolaHidupState extends State<PolaHidup> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();
  final TextEditingController _beratController = TextEditingController();
  final TextEditingController _penyakitController = TextEditingController();

  late final GenerativeModel _model;

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection("Data").doc(FirebaseAuth.instance.currentUser!.uid).collection("PolaHidup");
  final dbControl = DbWrapper();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(model: 'gemini-2.0-flash', apiKey: 'APIKEY');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                TextWidget(size: 25.0, content: "Pola Hidup", type: 2, colour: 0xFF5285AB, alignment: TextAlign.left,)
              ],
            ),
          ),
          const SizedBox(height: 10,),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height*0.85,
              width: MediaQuery.sizeOf(context).width,
              child: StreamBuilder(stream: collectionReference.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.data!.size >= 1){
                    return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: snapshot.data!.docs.map((e) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10,),
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 40,),
                                  const TextWidget(size: 40.0, content: "Halo Sobat!", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
                                  const TextWidget(size: 19.0, content: "Ini adalah pola hidup optimalmu", type: 0, colour: 0xFF7A7A7A, alignment: TextAlign.center),
                                  const SizedBox(height: 30,),
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(color: Color(0x40000000),
                                            blurRadius: 7.0,
                                            spreadRadius: 0.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(27),
                                        color: Colors.white
                                    ),
                                    width: MediaQuery.sizeOf(context).width*0.9,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.only(top: 20),
                                            child: TextWidget(size: 25.0, content: "${e['Nama']}", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    TextWidget(size: 16.0, content: "Jam tidur optimal:", type: 2, colour: 0xFF5285AB, alignment: TextAlign.start),
                                                    const SizedBox(width: 5),
                                                    TextWidget(size: 16.0, content: "${e['Jam']}", type: 1, colour: 0xFF364D63, alignment: TextAlign.start),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    TextWidget(size: 16.0, content: "Kalori/hari:", type: 2, colour: 0xFF5285AB, alignment: TextAlign.start),
                                                    const SizedBox(width: 5),
                                                    TextWidget(size: 16.0, content: "${e['Kalori']}", type: 1, colour: 0xFF364D63, alignment: TextAlign.start),
                                                  ],
                                                ),
                                                const SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    TextWidget(size: 16.0, content: "Berat optimal:", type: 2, colour: 0xFF5285AB, alignment: TextAlign.start),
                                                    const SizedBox(width: 5),
                                                    TextWidget(size: 16.0, content: "${e['Berat']}", type: 1, colour: 0xFF364D63, alignment: TextAlign.start),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                TextWidget(size: 16.0, content: "Saran kesehatan:", type: 2, colour: 0xFF5285AB, alignment: TextAlign.start),
                                                ReadMoreText(e['Saran'],
                                                    style: const TextStyle(color: Color(0xFF364D63)),
                                                    trimMode: TrimMode.Line,
                                                    trimLines: 10,
                                                    colorClickableText: const Color(0xFF364D63),
                                                    trimCollapsedText: 'Show more',
                                                    trimExpandedText: '...Show less',
                                                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                                const SizedBox(height: 13,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ButtonIconDef(
                                        width: MediaQuery.sizeOf(context).width*0.9,
                                        height: 40,
                                        type: 1,
                                        onTap: () async {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          await dbControl.deletePattern();
                                          if(kDebugMode){
                                            print("Data berhasil dihapus");
                                          }
                                        },
                                        text: "Ganti data saya", size: 20.0,
                                        icon: Icon(Icons.edit,
                                        color: Colors.white,
                                        size: 25,),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }else{
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10,),
                            const TextWidget(size: 25.0, content: "Yuk hidup sehat!", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
                            const TextWidget(size: 16.0, content: "Mohon lengkapi data berikut", type: 1, colour: 0xFF7A7A7A, alignment: TextAlign.center),
                            const SizedBox(height: 20,),
                            FieldText(text: "Nama", height: 50, desc: 'Nama', obs: false, control: _namaController, textType: 2,),
                            const SizedBox(height: 10,),
                            FieldText(text: "Umur", height: 50, desc: 'Umur (tahun)', obs: false, control: _umurController, textType: 2,),
                            const SizedBox(height: 10,),
                            FieldText(text: "Tinggi Badan", height: 50, desc: 'Tinggi Badan (cm)', obs: false, control: _tinggiController, textType: 2,),
                            const SizedBox(height: 10,),
                            FieldText(text: "Berat Badan", height: 50, desc: 'Berat Badan (kg)', obs: false, control: _beratController, textType: 2,),
                            const SizedBox(height: 10,),
                            FieldText(text: "Riwayat Penyakit", height: 50, desc: 'Contoh: diabetes, asma, tidak ada', obs: false, control: _penyakitController, textType: 2,),
                            const SizedBox(height: 30,),
                            _isLoading? CircularProgressIndicator(color: Color(0xFF5285AB),) :ButtonDef(
                              width: MediaQuery.sizeOf(context).width*0.85,
                              height: MediaQuery.sizeOf(context).height*0.05,
                              type: 1,
                              onTap: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  String nama = _namaController.text.trim();
                                  String umurText = _umurController.text.trim();
                                  String tinggi = _tinggiController.text.trim();
                                  String berat = _beratController.text.trim();
                                  String penyakit = _penyakitController.text.trim();

                                  // Validate inputs
                                  if (umurText.isEmpty || int.tryParse(umurText) == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Umur harus berupa angka yang valid.'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }
                                  if (tinggi.isEmpty || double.tryParse(tinggi) == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Tinggi harus berupa angka yang valid.'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }
                                  if (berat.isEmpty || double.tryParse(berat) == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Berat harus berupa angka yang valid.'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }

                                  // Generate content using the AI model
                                  final response = await _model.generateContent([
                                    Content.text(
                                        "Berdasarkan data berikut: Nama: $nama Umur: $umurText tahun Tinggi badan: $tinggi cm Berat badan: $berat kg Riwayat penyakit: $penyakit Tentukan pola hidup sehat yang disarankan, dengan format sebagai berikut tanpa ada tambahan kata-kata: nama: Andi jam tidur: -jam kalori per hari optimal: -kal berat badan optimal: -kg saran kesehatan: - saran1 - saran2 - saran3"
                                    )
                                  ]);

                                  if (response.text!.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('AI tidak memberikan respons yang valid.'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }

                                  final RegExp regex = RegExp(
                                    r'nama:\s*(.*?)\s*jam tidur:\s*(.*?)\s*kalori per hari optimal:\s*(.*?)\s*berat badan optimal:\s*(.*?)\s*saran kesehatan:\s*((?:- .*\s*)+)',
                                    caseSensitive: false,
                                  );
                                  final match = regex.firstMatch(response.text.toString());

                                  if (match != null) {
                                    String nama = match.group(1)!.trim();
                                    String jamTidur = match.group(2)!.trim();
                                    String kalori = match.group(3)!.trim();
                                    String berat = match.group(4)!.trim();
                                    String saran = match.group(5)!.trim();

                                    if (kDebugMode) {
                                      print("Nama: $nama");
                                      print("Jam Tidur: $jamTidur");
                                      print("Kalori: $kalori");
                                      print("Berat: $berat");
                                      print("Saran: $saran");
                                    }

                                    await dbControl.createPattern(nama, jamTidur, kalori, berat, saran);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Pola hidup berhasil dibuat!'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Format respons tidak sesuai.'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    if (kDebugMode) {
                                      print(response.text.toString());
                                    }
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Terjadi kesalahan: ${e.toString().trim()}'),
                                      duration: const Duration(seconds: 7),
                                    ),
                                  );
                                }
                              },
                              text: "Lihat pola hidup saya",
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}



