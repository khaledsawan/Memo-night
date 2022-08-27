import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../logic/Controllers/AddNote_Controller.dart';
import '../../../utils/colors.dart';

class AddNoteW extends StatefulWidget {
  const AddNoteW({Key? key}) : super(key: key);
  @override
  State<AddNoteW> createState() => _AddNoteWState();
}

class _AddNoteWState extends State<AddNoteW> {
  final AddNoteController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (!controller.isLoad) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          automaticallyImplyLeading: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add_a_photo,
                color: AppColors.white,
              ),
              tooltip: 'Add image',
              onPressed: () {
                Get.defaultDialog(
                    title: "Please Choose Image",
                    backgroundColor: AppColors.indoo,
                    titleStyle: const TextStyle(color: AppColors.blue),
                    barrierDismissible: true,
                    radius: 15,
                    content: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final imagePicker = ImagePicker();
                            controller.image = await imagePicker.getImage(
                                source: ImageSource.gallery);
                            controller.file = File(controller.image!.path);
                            if (controller.image != null) {
                              setState(() {
                                controller.imageName =
                                    basename(controller.image!.path);
                              });
                              Navigator.of(context).pop();
                            } else {
                              Get.snackbar('Error', 'no image selected');
                            }
                          },
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 1.h),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.photo_outlined,
                                    size: 24,
                                    color: AppColors.blue,
                                  ),
                                  SizedBox(width: 1.w),
                                  const Text(
                                    "From Gallery",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              )),
                        ),
                        InkWell(
                          onTap: () async {
                            final imagePicker = ImagePicker();
                            controller.image = await imagePicker.getImage(
                                source: ImageSource.camera);
                            controller.file = File(controller.image!.path);
                            if (controller.image != null) {
                              setState(() {
                                controller.imageName =
                                    basename(controller.image!.path);
                              });

                              Navigator.of(context).pop();
                            } else {
                              Get.snackbar('Error', 'no image selected');
                            }
                          },
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 1.h),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.camera,
                                    size: 24,
                                    color: AppColors.blue,
                                  ),
                                  SizedBox(width: 1.w),
                                  const Text(
                                    "From Camera",
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ));
              },
            ),
            SizedBox(
              width: 1.w,
            ), //IconButton
            IconButton(
              icon: const Icon(
                Icons.save,
                color: AppColors.white,
              ),
              tooltip: 'Save',
              onPressed: () async {
                setState(() {
                  controller.isLoad;
                });
                await controller.addNoteMethod();
                setState(() {
                  controller.isLoad;
                });
              },
            ),
            SizedBox(
              width: 1.w,
            ), //IconB//IconButton
          ],
          title: Text('Add Note'.tr,
              style: GoogleFonts.marckScript(
                fontSize: 43,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: AppColors.blue,
              )),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 50.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleSpacing: 00.0,
          centerTitle: true,
          toolbarHeight: 60.2,
          toolbarOpacity: 0.8,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Form(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 2.w,
                  top: 2.h,
                  right: 2.w,
                ),
                child: TextFormField(
                  maxLines: 3,
                  onSaved: (v) {
                    controller.titleController != v;
                  },
                  style: GoogleFonts.aBeeZee(
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(
                        bottom: 6.h,
                      ), // add padding to adjust icon
                      child: const Icon(
                        Icons.title_outlined,
                        size: 25,
                        color: AppColors.iconColor1,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(2.w, 1.h, 2.w, 0.h),
                margin: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 2.h),
                height: height - height * 0.3,
                child: TextFormField(
                  maxLines: 10000,
                  onSaved: (v) {
                    controller.bodyController != v;
                  },
                  controller: controller.bodyController,
                ),
              ),
              controller.imageName == ''
                  ? Container()
                  : Center(
                      child: Container(
                          width: width * 0.7,
                          height: height * 0.35,
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 20, right: 20),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.iconColor2,
                                        width: 1.w),
                                    borderRadius: BorderRadius.circular(2.h),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                          File(controller.image!.path),
                                        ))),
                              ),
                              Positioned(
                                  left: width - 15.w,
                                  top: 2.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        controller.imageName;
                                      });
                                      controller.clearImage();
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: AppColors.red,
                                      size: 6.h,
                                    ),
                                  ))
                            ],
                          )),
                    ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            automaticallyImplyLeading: true,

            title: Text('Add Note'.tr,
                style: GoogleFonts.marckScript(
                  fontSize: 43,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue,
                )),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
            ),
            elevation: 50.0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 60.2,
            toolbarOpacity: 0.8,

          ),
          body: const Center(
              child: CircularProgressIndicator(
            color: AppColors.mainColor,
          )));
    }
  }
}
