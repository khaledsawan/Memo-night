import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../Database/model/note_model.dart';
import '../../../logic/Controllers/edit_note_controller.dart';
import '../../../utils/colors.dart';

class EditNoteM extends StatefulWidget {
 final  NoteModel note;

  const EditNoteM({Key? key, required this.note}) : super(key: key);

  @override
  _EditNoteMState createState() => _EditNoteMState(note: note);
}

class _EditNoteMState extends State<EditNoteM> {
  late NoteModel note;
  _EditNoteMState({required this.note});
  EditNoteController controller = Get.find();
  @override
  initState() {
    super.initState();
    controller.bodyController.text = note.body;
    controller.titleController.text = note.title;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<EditNoteController>(builder: (controller) {
      return !controller.isLoading
          ? Scaffold(
              appBar: AppBar(
                  backgroundColor: AppColors.mainColor,
                  title: Title(
                      title: '',
                      color: AppColors.white,
                      child: Center(
                        child: Text(
                          'Update note',
                          style: GoogleFonts.marckScript(
                            fontSize: 30.sp,
                            color: AppColors.blue,
                          ),
                        ),
                      ))),
              floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.indigo,
                  onPressed: () async {
                    controller.updateNote(note);
                  },
                  child:  Icon(
                    Icons.update,
                    color: AppColors.blue,
                    size: 30.sp,
                  )),
              body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // await _download(imageUrl);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(8.w, 1.h,8.w, 0.1.h),
                                padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0.1.h),
                                width: width * 0.9.w,
                                height: height * 0.03.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(note.imageUrl)),
                                    borderRadius: BorderRadius.circular(2.h),
                                    border: Border.all(
                                        width: 0.5.w, color: AppColors.blue)),
                              ),
                            ),
                            GestureDetector(
                              onLongPress: () {
                                SelectableText(controller.titleController.text);
                                Clipboard.setData(
                                    ClipboardData(text: note.body));
                                Get.snackbar('', 'text has copy');
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(4.w, 1.h,4.w, 0.h),
                                child: TextFormField(
                                  controller: controller.titleController,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 24.sp,
                                    wordSpacing: 3,
                                    height: 0.15.h,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.blue,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onLongPress: () {
                                SelectableText(controller.bodyController.text);
                                Clipboard.setData(
                                    ClipboardData(text: note.body));
                                Get.snackbar('', 'text has copy');
                              },
                              child: Container(
                                margin:  EdgeInsets.only(left: 2.w, top: 1.5.h),
                                child: TextFormField(
                                  controller: controller.bodyController,
                                  maxLines: 10000,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 16.sp,
                                    wordSpacing: 3,
                                    height: 0.15.h,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin:  EdgeInsets.only(right: 2.w),
                        alignment: Alignment.bottomRight,
                        child: Text(note.time.toString(),
                            style: const TextStyle(color: AppColors.white70))),
                  ]))
          : Scaffold(
              appBar: AppBar(
                  backgroundColor: AppColors.mainColor,
                  title: Title(
                      title: '',
                      color: AppColors.white,
                      child: Center(
                        child: Text(
                          'Update note'.tr,
                          style: GoogleFonts.marckScript(
                            fontSize: 30.sp,
                            color: AppColors.blue,
                          ),
                        ),
                      ))),
              body: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.blue,
                ),
              ),
            );
    });
  }
}
