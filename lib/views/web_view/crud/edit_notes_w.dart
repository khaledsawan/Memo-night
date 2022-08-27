import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../Database/model/note_model.dart';
import '../../../logic/Controllers/edit_note_controller.dart';
import '../../../utils/colors.dart';

class EditNoteW extends StatefulWidget {
  final NoteModel note;

  const EditNoteW({Key? key, required this.note}) : super(key: key);

  @override
  _EditNoteWState createState() => _EditNoteWState(note: note);
}

class _EditNoteWState extends State<EditNoteW> {
  late NoteModel note;
  _EditNoteWState({required this.note});
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
                automaticallyImplyLeading: true,
                actions: <Widget>[
                  SizedBox(
                    width: 1.w,
                  ), //IconButton
                  IconButton(
                    icon: const Icon(
                      Icons.save,
                      color: AppColors.white,
                      size: 30,
                    ),
                    tooltip: 'save',
                    onPressed: () async {
                      await controller.updateNote(note);
                    },
                  ),
                  SizedBox(
                    width: 1.w,
                  ), //IconB//IconButton
                ],
                title: Text('Edit Note',
                    style: GoogleFonts.marckScript(
                      fontSize: 55,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue,
                    )),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
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

              body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                margin: EdgeInsets.fromLTRB(2.w, 1.h, 2.w, 0.2.h),
                                width: width * 0.4,
                                height: height * 0.03.h,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(note.imageUrl)),
                                    borderRadius: BorderRadius.circular(2.h),
                                    border:
                                    Border.all(width: 2, color: AppColors.blue)),
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
                                margin: EdgeInsets.fromLTRB(1.w, 0, 2.w, 0.h),
                                child: TextFormField(
                                  controller: controller.titleController,
                                  maxLines: 3,
                                  style: GoogleFonts.lato(
                                    fontSize: 22,
                                    wordSpacing: 3,
                                    height: 1.4,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white70,
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
                                margin: EdgeInsets.only(left:1.w, top: 1.5.h),
                                child: TextFormField(
                                  controller: controller.bodyController,
                                  maxLines: 10000,
                                  style: GoogleFonts.lato(
                                    fontSize: 18,
                                    wordSpacing: 3,
                                    height: 1.4,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 2.w),
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
