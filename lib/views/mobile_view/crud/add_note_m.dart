import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../logic/Controllers/AddNote_Controller.dart';
import '../../../utils/colors.dart';

class AddNoteM extends StatefulWidget {
  const AddNoteM({Key? key}) : super(key: key);
  @override
  State<AddNoteM> createState() => _AddNoteMState();
}

class _AddNoteMState extends State<AddNoteM> {
  final AddNoteController controller = Get.find();
  showBottomSheet(context) {
    double height = MediaQuery.of(context).size.height;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.fromLTRB(2.w, 1.h, 1.w, 1.h),
            height: height * 0.025.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please Choose Image",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
                      padding: EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 1.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_outlined,
                            size: 22.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 18.sp),
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
                      padding: EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 1.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera,
                            size: 22.sp,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "From Camera",
                            style: TextStyle(fontSize: 18.sp),
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
              backgroundColor: AppColors.mainColor,
              automaticallyImplyLeading: true,
              title: Title(
                title: 'Title',
                color: AppColors.iconColor1,
                child: Text('Add Note'.tr,
                    style: GoogleFonts.marckScript(
                      fontSize: 30.sp,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    )),
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
                      padding: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 0.h),
                      margin: EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 0.1.h),
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
                          labelStyle: TextStyle(fontSize: 18.sp),
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
                      padding: EdgeInsets.fromLTRB(2.w, 1.h, 2.w, 0.h),
                      margin: EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 2.h),
                      height: height-height*0.4,
                      child: TextFormField(
                        maxLines: 10000,
                        autovalidateMode: AutovalidateMode.onUserInteraction,

                        onSaved: (v) {
                          controller.bodyController != v;
                        },
                        controller: controller.bodyController,

                      ),
                    ),
                    controller.imageName == ''
                        ? GestureDetector(
                            onTap: () {
                              showBottomSheet(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 30.w, top: 0, right: 30.w, bottom: 2.h),

                              height: height*0.07,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(1.h),
                                border: Border.all(color: AppColors.blue),
                              ),
                              child:  Center(
                                  child: Text(
                                "Add image".tr,
                                style: TextStyle(color: AppColors.iconColor1,fontSize: 14.sp),
                              )),
                            ),
                          )
                        : Container(

                            width: width-width*0.05,
                            height: height * 0.35,
                            child: Stack(
                              //fit: StackFit.expand,
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
                                    left: width-15.w,
                                    top: 2.h,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          controller.imageName;
                                        });
                                        controller.clearImage();
                                      },
                                      child:  Icon(
                                        Icons.clear,
                                        color: AppColors.red,
                                        size: 6.h,
                                      ),
                                    ))
                              ],
                            )),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                child:  Icon(Icons.add, color: AppColors.blue,size: 5.h,),
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
        : Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.mainColor,
              automaticallyImplyLeading: true,
              title: Title(
                title: 'Title',
                color: AppColors.iconColor1,
                child: Text('Add Note'.tr,
                    style: GoogleFonts.marckScript(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    )),
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
