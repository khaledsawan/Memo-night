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

class NoteBodyPageW extends StatefulWidget {
  final NoteModel note;

  const NoteBodyPageW({Key? key, required this.note}) : super(key: key);

  @override
  _NoteBodyPageWState createState() => _NoteBodyPageWState(note: this.note);
}

class _NoteBodyPageWState extends State<NoteBodyPageW> {
  late NoteModel note;

  _NoteBodyPageWState({required this.note});

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
          automaticallyImplyLeading: true,
          actions: <Widget>[
            SizedBox(
              width: 1.w,
            ), //IconButton
            IconButton(
              icon: const Icon(
                Icons.edit_note,
                color: AppColors.white,
                size: 30,
              ),
              tooltip: 'edit note',
              onPressed: () async {
                Get.lazyPut(() => EditNoteController());
                Get.to(EditNote(note: note));
              },
            ),
            SizedBox(
              width: 1.w,
            ), //IconB//IconButton
          ],
          title: Text(note.title,
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
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          SelectableText(note.body);
                          Clipboard.setData(ClipboardData(text: note.body));
                          Get.snackbar(
                            '',
                            '',
                            messageText: Text('text has been copy' ,style: GoogleFonts.marckScript(
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
                            ),
                            borderRadius: 20,
                            maxWidth: 350,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            snackStyle: SnackStyle.FLOATING,
                          );
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
                  margin: EdgeInsets.only(right: 2.w),
                  alignment: Alignment.bottomRight,
                  child: Text(note.time.toString(),
                      style: const TextStyle(color: Colors.white))),
            ]));
  }
}
