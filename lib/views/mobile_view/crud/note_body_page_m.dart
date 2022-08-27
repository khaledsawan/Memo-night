import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sizer/sizer.dart';
import '../../../Database/model/note_model.dart';
import '../../../logic/Controllers/edit_note_controller.dart';
import '../../../utils/colors.dart';
import '../../View/crud/edit_note.dart';

class NoteBodyPageM extends StatefulWidget {
  final NoteModel note;

  const NoteBodyPageM({Key? key, required this.note}) : super(key: key);

  @override
  _NoteBodyPageMState createState() => _NoteBodyPageMState(note: this.note);
}

class _NoteBodyPageMState extends State<NoteBodyPageM> {
  late NoteModel note;

  _NoteBodyPageMState({required this.note});

  Future<void> _download(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final imageName = path.basename(imageUrl);
    final appDir = await path_provider.getApplicationDocumentsDirectory();
    final localPath = path.join(appDir.path, imageName);
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            title: Title(
                title: '',
                color: Colors.white,
                child: Center(
                  child: Text(
                    note.title,
                    style: GoogleFonts.marckScript(
                      fontSize: 30.sp,
                      color: AppColors.blue,
                    ),
                  ),
                ))),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.indigo,
            onPressed: () async {
              Get.lazyPut(() => EditNoteController());
              Get.to(EditNote(note: note));
            },
            child: Icon(
              Icons.edit_note,
              color: AppColors.blue,
              size: 35.sp,
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
                          margin: EdgeInsets.fromLTRB(8.w, 1.h, 8.w, 0.1.h),
                          width: width * 0.9.w,
                          height: height * 0.03.h,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(note.imageUrl)),
                              borderRadius: BorderRadius.circular(2.h),
                              border:
                                  Border.all(width:0.5.w, color: AppColors.blue)),
                        ),
                      ),
                      GestureDetector(
                        onLongPress: () {
                          SelectableText(note.body);
                          Clipboard.setData(ClipboardData(text: note.body));
                          Get.snackbar('', '',messageText: Text('text has been copy' ,style: GoogleFonts.marckScript(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white,
                          ),),
                            backgroundColor: AppColors.mainColor2,
                            titleText: Text(
                              'copy',
                              style: GoogleFonts.marckScript(
                                fontSize: 28,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),);
                        },
                        child: Container(
                          width: width,
                          margin: EdgeInsets.only(left: 1.w, top: 2.h),
                          child: Text(
                            note.body,
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
                  margin:  EdgeInsets.only(right: 2.w),
                  alignment: Alignment.bottomRight,
                  child: Text(note.time.toString(),
                      style: const TextStyle(color: Colors.white))),
            ]));
  }
}
