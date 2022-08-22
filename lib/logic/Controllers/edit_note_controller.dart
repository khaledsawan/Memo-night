import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memo_night/views/screens/crud/index.dart';
import '../../Databease/model/note_model.dart';

class EditNoteController extends GetxController {
  late TextEditingController titleController, bodyController;
  bool isLoading = false;
  @override
  void onInit() {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() async {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  CollectionReference notes = FirebaseFirestore.instance.collection('Notes');

  Future<void> updateNote(NoteModel note) async {
    isLoading = true;
    update();
    try {
      await notes.doc('p2Vm6czIR9VXEhF8C5Vx').update({
        'body': bodyController.text,
        'title': titleController.text,
        'imageUrl': note.imageUrl,
        'userid': FirebaseAuth.instance.currentUser!.uid,
        'time': DateTime.now(),
      }).then((value) {
        isLoading = false;
        Get.to(const Index());
      }).catchError((error) => GetSnackBar(
            message: error.toString(),
          ));
    } catch (e) {
      GetSnackBar(
        message: e.toString(),
      );
    }

    isLoading = false;
    update();
  }
}
