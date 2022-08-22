import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:memo_night/Databease/model/note_model.dart';
import 'package:memo_night/logic/Controllers/edit_note_controller.dart';
import 'package:memo_night/views/screens/crud/edit_notes.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import '../../../utils/colors.dart';

class NoteBodyPage extends StatefulWidget {
  final NoteModel note;

  const NoteBodyPage({Key? key, required this.note}) : super(key: key);

  @override
  _NoteBodyPageState createState() => _NoteBodyPageState(note: this.note);
}

class _NoteBodyPageState extends State<NoteBodyPage> {
  late NoteModel note;

  _NoteBodyPageState({required this.note});

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
                      fontSize: 35,
                      color: AppColors.blue,
                    ),
                  ),
                ))),
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.edit_note,
              color: AppColors.blue,
              size: 35,
            ),
            backgroundColor: Colors.indigo,
            onPressed: () async {
              Get.lazyPut(()=>EditNoteController());
              Get.to(EditNote(
                 note:note));
            }),
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
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          width: width * 0.9,
                          height: height * 0.25,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(note.imageUrl)),
                              borderRadius: BorderRadius.circular(30),
                              border:
                                  Border.all(width: 1, color: AppColors.blue)),
                        ),
                      ),
                      GestureDetector(
                        onLongPress: () {
                          SelectableText(note.body);
                          Clipboard.setData(ClipboardData(text: note.body));
                          Get.snackbar('', 'text has copy');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 4, top: 10),
                          child: Text(
                            note.body,
                            maxLines: 500,
                            style: GoogleFonts.robotoCondensed(
                              fontSize: 22,
                              wordSpacing: 3,
                              height: 1.5,
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
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.bottomRight,
                  child: Text(note.time.toString(),
                      style: const TextStyle(color: Colors.white))),
            ]));
  }
}
