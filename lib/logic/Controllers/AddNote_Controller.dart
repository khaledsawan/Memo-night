import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memo_night/Databease/Services/Notes_services.dart';


class AddNoteController extends GetxController {
  var isLoading = false.obs;
  final insertProductForKey = GlobalKey<FormState>();
  late TextEditingController titleController, bodyController;
  String title = '', body = '';
  late Reference ref;
  late File file;


  @override
  void onInit() {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    super.onInit();
  }
  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
  String? validateData(String value) {
    if (value.length < 1)
      return "Empty";
    else return null;
  }

   AddNote_method() async {
    bool invalidate = insertProductForKey.currentState!.validate();
    if (invalidate) {

      isLoading(true);
      try {
        Notes_services.AddNote_services(file: file,body: bodyController.text,title:titleController.text);
      } finally {
        isLoading(false);
      }
    }
    else Get.snackbar('set value', ' enter value');
  }
}
