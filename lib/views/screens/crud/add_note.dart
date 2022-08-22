import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_night/utils/colors.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memo_night/logic/Controllers/AddNote_Controller.dart';
class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);
  @override
  State<AddNote> createState() => _AddNoteState();
}
class _AddNoteState extends State<AddNote> {
  final AddNoteController controller = Get.find();
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
                    final _imagePicker = ImagePicker();
                    controller.image = await _imagePicker.getImage(
                        source: ImageSource.gallery);
                    controller.file = File(controller.image!.path);
                    if (controller.image != null) {
                      setState(() {
                        controller.imageName = basename(controller.image!.path);
                      });
                      Navigator.of(context).pop();
                    } else {
                      Get.snackbar('Error', 'no image selected');
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
                    final _imagePicker = ImagePicker();
                    controller.image =
                        await _imagePicker.getImage(source: ImageSource.camera);
                    controller.file = File(controller.image!.path);
                    if (controller.image != null) {
                      setState(() {
                        controller.imageName = basename(controller.image!.path);
                      });

                      Navigator.of(context).pop();
                    } else {
                      Get.snackbar('Error', 'no image selected');
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return !controller.isLoad
        ? Scaffold(
            appBar: AppBar(
              backgroundColor:AppColors.mainColor,
              automaticallyImplyLeading: true,
              title: Title(
                title: 'Title',
                color: AppColors.iconColor1,
                child: Text(
                  'Add Note'.tr,
                  style: GoogleFonts.marckScript(
                    fontSize: 35,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blue,
                  )
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Form(
              child: Center(
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                      margin: const EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 10.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (v) {
                          return controller.validateString(v!);
                        },
                        onSaved: (v) {
                          controller.titleController != v;
                        },
                        controller: controller.titleController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Title'.tr,
                          labelStyle: const TextStyle(fontSize: 25),
                          prefixIcon: const Padding(
                            padding:
                                EdgeInsets.only(), // add padding to adjust icon
                            child: Icon(
                              Icons.title_outlined,
                              color: AppColors.iconColor1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      margin: const EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 5.0),
                      height: height * 0.3,
                      child: TextFormField(
                        maxLines: 10,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (v) {
                          return controller.validateString(v!);
                        },
                        onSaved: (v) {
                          controller.bodyController != v;
                        },
                        controller: controller.bodyController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'body',
                          labelStyle: TextStyle(fontSize: 20),
                          prefixIcon: Padding(
                            padding:
                                EdgeInsets.only(), // add padding to adjust icon
                            child: Icon(
                              Icons.subtitles,
                              color: AppColors.iconColor1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    controller.imageName == ''
                        ? GestureDetector(
                            onTap: () {
                              showBottomSheet(context);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(12, 12, 12, 12),
                              margin: const EdgeInsets.only(
                                  left: 10, top: 0, right: 10, bottom: 10.0),
                              width: double.infinity,
                              height: 50,
                              //color: Color(0xFF2A0445),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: AppColors.blue),
                              ),
                              child: const Center(
                                  child: Text(
                                "Add image",
                                style: TextStyle(color: AppColors.iconColor1),
                              )),
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                            margin: const EdgeInsets.only(
                                left: 8, top: 0, right: 8, bottom: 10.0),
                            width: width,
                            height: height * 0.35,
                            child: Stack(
                              //fit: StackFit.expand,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.iconColor2,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(45),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                            File(controller.image!.path),
                                          ))),
                                ),
                                Positioned(
                                    left: width - 85,
                                    top: 10,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.imageName;
                                        });
                                        controller.clearImage();

                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        color: AppColors.red,
                                        size: 35,
                                      ),
                                    ))
                              ],
                            )),


                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add, color: AppColors.blue),
                backgroundColor: Colors.indigo,
                onPressed: () async {
                  setState(() {
                    controller.isLoad;
                  });
                  await controller.addNoteMethod();
                  setState(() {
                    controller.isLoad;
                  });
                }),
          )
        :  Scaffold(
        appBar: AppBar(
          backgroundColor:AppColors.mainColor,
          automaticallyImplyLeading: true,
          title: Title(
            title: 'Title',
            color: AppColors.iconColor1,
            child: Text(
              'Add Note'.tr,
              style: GoogleFonts.marckScript(
                fontSize: 35,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: AppColors.blue,
              )
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
            body: const Center(
                child: CircularProgressIndicator(
            color: AppColors.mainColor,
          )));
  }
}
