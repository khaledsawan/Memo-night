import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:memo_night/routes/routes.dart';

class Notes_services {
  static late Reference ref;
  static CollectionReference notesref =
      FirebaseFirestore.instance.collection("Notes");

  static Future<void> AddNote_services({
    required String title,
    required String body,
    required File file,
  }) async {
    await ref.putFile(file);
    var imageurl = await ref.getDownloadURL();
    print(imageurl);
    print('//////////////////////////////////////////////////');
    await notesref.add({
      "title": 'dfsfdsf',
      "body": 'bodyController.text',
      "imageurl": 'imageurl',
      "userid": FirebaseAuth.instance.currentUser!.uid
    }).then((value) {
      Get.toNamed(AppRoutes.notes);
    }).catchError((e) {
      print("$e");
    });
  }
}
