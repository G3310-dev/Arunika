import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Component/button.dart';
import '../Component/text_model.dart';

class Obat extends StatefulWidget {
  const Obat({super.key});

  @override
  State<Obat> createState() => _ObatState();
}

class _ObatState extends State<Obat> {
  Future<void> _deleteItem(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('Obat')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("Jadwal Obat")
          .doc(docId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jadwal sudah dihapus')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                      content: "Obat Anda",
                      type: 2,
                      colour: 0xFF5285AB,
                      alignment: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance
                          .collection('Obat')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .collection("Jadwal Obat")
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Column(
                        children: [
                          SizedBox(height: MediaQuery.sizeOf(context).height*0.4,),
                          Icon(Icons.nights_stay_rounded, size: 50, color: Color(0xFF7A7A7A),),
                          const SizedBox(height: 10,),
                          const Center(
                              child: TextWidget(size: 20.0, content: "Tidak ada jadwal apapun", type: 2, colour: 0xFF7A7A7A, alignment: TextAlign.center)
                          ),
                        ],
                      );
                    }
                    final items = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 15,
                            right: 15,
                          ),
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x40000000),
                                blurRadius: 7.0,
                                spreadRadius: 0.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: TextWidget(
                                  size: 18.0,
                                  content: item['Judul'],
                                  type: 2,
                                  colour: 0xFF5285AB,
                                  alignment: TextAlign.start,
                                ),
                                subtitle:
                                    item['Deskripsi'] != ''
                                        ? Container(
                                          margin: EdgeInsets.only(top: 6),
                                          child: TextWidget(
                                            size: 18.0,
                                            content: item['Deskripsi'],
                                            type: 1,
                                            colour: 0xFF7A7A7A,
                                            alignment: TextAlign.start,
                                          ),
                                        )
                                        : null,
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete_rounded,
                                    color: Colors.red,
                                  ),
                                  onPressed: (){
                                    Widget cancelButton = TextButton(
                                      child: const TextWidget(size: 15.0, content: "Tidak", type: 2, colour: 0xFF5285AB, alignment: TextAlign.start),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                    Widget launchButton = TextButton(
                                      child: const TextWidget(size: 15.0, content: "Yes", type: 2, colour: 0xFF5285AB, alignment: TextAlign.start),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _deleteItem(item.id,);
                                      },
                                    );
                                    AlertDialog alert = AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const TextWidget(size: 25.0, content: "PERINGATAN!", type: 1, colour: 0xFF5285AB, alignment: TextAlign.start),
                                      content: const TextWidget(size: 15.0, content: "Kamu ingin menghapus jadwal ini?", type: 2, colour: 0xFF5285AB, alignment: TextAlign.start),
                                      actions: [
                                        cancelButton,
                                        launchButton,
                                      ],
                                    );

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  }
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 20, bottom: 5),
                                child: ButtonDef(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height:
                                      MediaQuery.of(context).size.height *
                                      0.029,
                                  type: 1,
                                  onTap: () async {
                                    try {
                                      final Event event = Event(
                                        title: item['Judul'],
                                        description: item['Deskripsi'],
                                        startDate: DateTime.now().add(
                                          Duration(seconds: 5),
                                        ),
                                        endDate: DateTime.now()
                                            .add(Duration(seconds: 5))
                                            .add(Duration(hours: 1)),
                                        iosParams: const IOSParams(
                                          reminder: Duration(minutes: 10),
                                        ),
                                        androidParams: const AndroidParams(
                                          emailInvites: [],
                                        ),
                                        recurrence: Recurrence(
                                          frequency: Frequency.daily,
                                        ),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(e.toString().trim()),
                                          duration: const Duration(
                                            milliseconds: 700,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  text: "Tambah ke kalender",
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/addObat"),
              child: Container(
                margin: const EdgeInsets.only(right: 20, bottom: 20),
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xFF5285AB),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 37.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
