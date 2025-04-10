import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbWrapper{
  final _fire = FirebaseFirestore.instance;

  createPattern(nama, jam, kalori, berat, saran) async {
    try{
      _fire.collection("Data").doc(FirebaseAuth.instance.currentUser!.uid).collection("PolaHidup").add({
        "Nama": nama,
        "Email": FirebaseAuth.instance.currentUser!.email,
        "Jam": jam,
        "Kalori": kalori,
        "Berat": berat,
        "Saran": saran,
      });
    } catch(e){
      log(e.toString());
    }
  }
  deletePattern() async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection("Data").doc(FirebaseAuth.instance.currentUser!.uid).collection("PolaHidup");
      final querySnapshot = await collectionRef.get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      log('Delete failed: ${e.toString()}');
    }
  }
}