import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:memo_night/routes/routes.dart';

class Notes_services {

  static CollectionReference notesRef =
      FirebaseFirestore.instance.collection("Notes");
  static Future<void> addNoteService( {
    // required Reference reference,
    required String title,
    required String time,
    required String body,
    required String image,
  }) async {
    await notesRef.add({
      "title": title,
      "body": body,
      "time": Timestamp.now(),
      "imageUrl": image,
      "userid": FirebaseAuth.instance.currentUser!.uid
    }).then((value) {
      Get.offNamed(AppRoutes.notes);
    }).catchError((e) {
      GetSnackBar(message: "$e");
    });
  }
}
