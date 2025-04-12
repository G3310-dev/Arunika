import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

import '../Component/button.dart';
import '../Component/text_field.dart';
import '../Component/text_model.dart';
import '../Wrapper/database_wrapper.dart';

class AddObat extends StatelessWidget {
  const AddObat({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    final dbControl = DbWrapper();

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
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
                      ),
                    ),
                    SizedBox(width: 10,),
                    TextWidget(size: 25.0, content: "Obat Anda", type: 2, colour: 0xFF5285AB, alignment: TextAlign.left,)
                  ],
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  const TextWidget(size: 40.0, content: "Halo Sobat!", type: 2, colour: 0xFF5285AB, alignment: TextAlign.center),
                  const TextWidget(size: 19.0, content: "Jangan lupa obatnya ya!", type: 0, colour: 0xFF7A7A7A, alignment: TextAlign.center),
                  const SizedBox(height: 30,),
                  FieldText(text: "Nama Obat (penting)", height: 50, desc: 'Title', obs: false, control: titleController, textType: 2,),
                  const SizedBox(height: 10,),
                  FieldText(text: "Keterangan", height: 100, desc: 'Description', obs: false, control: descController, textType: 1,),
                  const SizedBox(height: 10,),
                  ButtonDef(
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    type: 1,
                    onTap: () async {
                      if (titleController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Mohon masukan judul"),
                          duration: Duration(milliseconds: 1000),
                        ));
                      } else {
                        await dbControl.createMed(titleController.text, descController.text);

                        final Event event = Event(
                          title: titleController.text,
                          description: descController.text,
                          startDate: DateTime.now().add(Duration(seconds: 5)),
                          endDate: DateTime.now().add(Duration(seconds: 5)).add(Duration(hours: 1)),
                          iosParams: const IOSParams(reminder: Duration(minutes: 10)),
                          androidParams: const AndroidParams(emailInvites: [],),
                          recurrence: Recurrence(
                            frequency: Frequency.daily,
                          ),
                        );

                        Add2Calendar.addEvent2Cal(event);

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Column(
                            children: [
                              Text("Pengingat anda sudah ditambahkan!"),
                            ],
                          ),
                          duration: Duration(milliseconds: 2000),
                        ));
                        Navigator.pop(context);
                      }
                    },
                    text: "Tambahkan Pengingat ",
                    size: 18,
                  ),
                  const SizedBox(height: 7,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}