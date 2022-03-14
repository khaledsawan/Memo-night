import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo_night/logic/Controllers/AddNote_Controller.dart';

class AddNote extends GetView<AddNoteController> {
  AddNote({Key? key}) : super(key: key);

  late TextEditingController titleController, bodyController;
  @override
  AddNoteController controller = Get.find();

  CollectionReference notesref = FirebaseFirestore.instance.collection("Notes");
  late Reference ref;
  late File file;
  var image_name;

  showBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    var picked = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    if (picked != null) {
                      controller.file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      image_name = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("$image_name");
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.photo_outlined,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
                InkWell(
                  onTap: () async {
                    var picked = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    if (picked != null) {
                      controller.file = File(picked.path);
                      var rand = Random().nextInt(100000);
                      var imagename = "$rand" + basename(picked.path);
                      ref = FirebaseStorage.instance
                          .ref("images")
                          .child("$imagename");
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Text(
                            "From Camera",
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111631),
        automaticallyImplyLeading: true,
        title: Title(
          title: 'Title',
          color: Colors.white,
          child: Text(
            'Add note'.tr,
            style: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          //onPressed:() => Navigator.pop(context, false),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        child: Center(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                margin:
                    const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) {
                    return controller.validateData(v!);
                  },
                  onSaved: (v) {
                    controller.titleController != v;
                  },
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'title'.tr,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(), // add padding to adjust icon
                      child: Icon(
                        Icons.title_outlined,
                        color: Color(0xFF7423A8),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                margin:
                    const EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 10.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) {
                    return controller.validateData(v!);
                  },
                  onSaved: (v) {
                    controller.bodyController != v;
                  },
                  controller: controller.bodyController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'body'.tr,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(), // add padding to adjust icon
                      child: Icon(
                        Icons.subtitles,
                        color: Color(0xFF7423A8),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showBottomSheet(context);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  margin: const EdgeInsets.only(
                      left: 10, top: 0, right: 10, bottom: 10.0),
                  width: double.infinity,
                  height: 50,
                  //color: Color(0xFF2A0445),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: const Center(
                      child: Text(
                    "Add image",
                    style: TextStyle(color: Colors.deepPurple),
                  )),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  height: 60,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: RaisedButton(
                    textColor: Colors.white,
                    shape: const StadiumBorder(side: BorderSide()),
                    child: Text('Add'.tr),
                    color: const Color(0xFF2A0445),
                    onPressed: () async {
                      await controller.AddNote_method();
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
