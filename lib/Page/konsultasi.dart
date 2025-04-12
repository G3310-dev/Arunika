import 'package:arunika/Component/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../Component/text_model.dart';


class Contact {
  final String name;
  final String image;
  final String desc;
  final String spec;

  Contact(this.name, this.image, this.desc, this.spec);
}

class Konsultasi extends StatelessWidget {
  Konsultasi({super.key});

  final List<Contact> contacts = [
    Contact(
        'dr. Andi Prasetya, Sp.PD',
        'asset/image/dokter2.jpg',
        'Memiliki pengalaman lebih dari 12 tahun di bidang penyakit dalam. \n\nTelah menangani ratusan kasus diabetes, hipertensi, infeksi saluran pernapasan kronis (seperti TB dan pneumonia), serta penyakit autoimun seperti lupus. \n\nAktif sebagai pembicara seminar edukasi kesehatan masyarakat dan menulis jurnal medis tentang manajemen pasien dengan gangguan metabolik.',
        'Penyakit Dalam'
    ),
    Contact(
        'dr. Siska Melani, Sp.A',
        'asset/image/dokter1.jpg',
        'Berpengalaman lebih dari 10 tahun menangani anak-anak dari bayi hingga remaja. \n\nTerlibat aktif dalam program imunisasi nasional dan edukasi tumbuh kembang anak. \n\nIa juga memberikan layanan konsultasi anak berkebutuhan khusus dan nutrisi anak. Sering tampil dalam webinar parenting dan kesehatan anak.',
        'Anak'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.05),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5, left: 10),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 30,
                    color: Color(0xFF5285AB),
                  ),
                ),
                const SizedBox(width: 10),
                const TextWidget(
                  size: 25.0,
                  content: "Konsultasi Dokter",
                  type: 2,
                  colour: 0xFF5285AB,
                  alignment: TextAlign.left,
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.85,
            margin: EdgeInsets.only(left: 15, right: 15),
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.8,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Color(0x40000000),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(contact.image),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextWidget(size: 19.0,
                            content: contact.name,
                            type: 2,
                            colour: 0xFF5285AB,
                            alignment: TextAlign.start),
                      ],
                    ),
                    subtitle: Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(size: 17.0,
                              content: "Spesialis ${contact.spec}",
                              type: 2,
                              colour: 0xFF7A7A7A,
                              alignment: TextAlign.start),
                          TextWidget(size: 16.0,
                              content: contact.desc,
                              type: 1,
                              colour: 0xFF7A7A7A,
                              alignment: TextAlign.start),
                          SizedBox(height: 20,),
                          ButtonIconDef(
                              width: MediaQuery.sizeOf(context).width*0.8,
                              height: 34,
                              type: 1,
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Column(
                                    children: [
                                      Text("Menghubungi dokter ${contact.name}"),
                                    ],
                                  ),
                                  duration: Duration(milliseconds: 2000),
                                ));
                              },
                              text: "Hubungi dokter ini",
                              size: 18,
                              icon: Icon(Icons.phone_rounded, color: Colors.white,)
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
