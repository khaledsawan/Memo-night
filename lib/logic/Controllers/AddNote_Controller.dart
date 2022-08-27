import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../Database/Services/Notes_services.dart';

class AddNoteController extends GetxController {
  final insertProductForKey = GlobalKey<FormState>();
  late TextEditingController titleController, bodyController;
  String title = '', body = '';
  bool isLoad = false;
  late String imageName = '';
  late String imageUrl = '1';
  late File file;
  Uint8List? uint8list;
  final _firebaseStorage = FirebaseStorage.instance;
  @override
  void onInit() {
    titleController = TextEditingController();
    bodyController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() async {
    imageName = '';
    imageUrl = '1';
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  clearImage() {
    imageName = '';
    imageUrl = '1';
    update();
  }

  String? validateString(String value) {
    if (value.isEmpty) {
      return "short password";
    } else {
      return null;
    }
  }

  addNoteMethod() async {
    bool deviceType = SizerUtil.deviceType == DeviceType.web;
    if (!deviceType) {
      isLoad = true;
      update();
      var rand = Random().nextInt(100000);
      if (titleController.text.isNotEmpty ||
          bodyController.text.isNotEmpty ||
          imageName.isNotEmpty) {
        if (imageName.isNotEmpty) {
          String imageNewName = "$rand$imageName";
          update();
          try {
            update();
            await _firebaseStorage
                .ref()
                .child('images/$imageNewName')
                .putFile(file)
                .then((snapshot) async {
              String downloadUrl = await snapshot.ref.getDownloadURL();
              imageUrl = downloadUrl;
              DateTime now = DateTime.now();
              String formattedDate = DateFormat.yMMMEd().format(now);
              await Notes_services.addNoteService(
                  time: formattedDate,
                  image: downloadUrl.isEmpty ? '' : downloadUrl,
                  body: bodyController.text.toString().isEmpty
                      ? ''
                      : bodyController.text.toString(),
                  title: titleController.text.toString().isEmpty
                      ? ''
                      : titleController.text.toString());
              update();
            });
          } finally {
            update();
          }
        } else {
          update();
          try {
            update();
            DateTime now = DateTime.now();
            String formattedDate = DateFormat.yMMMEd().format(now);
            await Notes_services.addNoteService(
                time: formattedDate,
                image: '',
                body: bodyController.text.toString().isEmpty
                    ? ''
                    : bodyController.text.toString(),
                title: titleController.text.toString().isEmpty
                    ? ''
                    : titleController.text.toString());
            update();
          } finally {
            update();
          }
        }
      } else {
        Get.snackbar('Empty Note', '');
        update();
      }
      isLoad = false;
      update();
    } else {
      isLoad = true;
      update();
      var rand = Random().nextInt(100000);
      if (titleController.text.isNotEmpty ||
          bodyController.text.isNotEmpty ||
          imageName.isNotEmpty) {
        if (imageName.isNotEmpty) {
          String imageNewName = "$rand$imageName";
          update();
          try {
            update();
            await _firebaseStorage
                .ref()
                .child('images/$imageNewName')
                .putData(
                  uint8list!,
                  SettableMetadata(contentType: 'image/jpeg'),
                )
                .then((snapshot) async {
              String downloadUrl = await snapshot.ref.getDownloadURL();
              imageUrl = downloadUrl;
              DateTime now = DateTime.now();
              String formattedDate = DateFormat.yMMMEd().format(now);
              await Notes_services.addNoteService(
                  time: formattedDate,
                  image: downloadUrl.isEmpty ? '' : downloadUrl,
                  body: bodyController.text.toString().isEmpty
                      ? ''
                      : bodyController.text.toString(),
                  title: titleController.text.toString().isEmpty
                      ? ''
                      : titleController.text.toString());
              update();
            });
          } finally {
            update();
          }
        } else {
          update();
          try {
            update();
            DateTime now = DateTime.now();
            String formattedDate = DateFormat.yMMMEd().format(now);
            await Notes_services.addNoteService(
                time: formattedDate,
                image: '',
                body: bodyController.text.toString().isEmpty
                    ? ''
                    : bodyController.text.toString(),
                title: titleController.text.toString().isEmpty
                    ? ''
                    : titleController.text.toString());
            update();
          } finally {
            update();
          }
        }
      } else {
        Get.snackbar('Empty Note', '');
        update();
      }
      isLoad = false;
      update();
    }
  }
}
