import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_night/logic/Controllers/edit_note_controller.dart';
import '../../../Databease/model/note_model.dart';
import '../../../utils/colors.dart';

class EditNote extends StatefulWidget {
 final  NoteModel note;

  const EditNote({Key? key, required this.note}) : super(key: key);

  @override
  _EditNoteState createState() => _EditNoteState(note: note);
}

class _EditNoteState extends State<EditNote> {
  late NoteModel note;
  _EditNoteState({required this.note});
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
                            fontSize: 35,
                            color: AppColors.blue,
                          ),
                        ),
                      ))),
              floatingActionButton: FloatingActionButton(
                  child: const Icon(
                    Icons.update,
                    color: AppColors.blue,
                    size: 35,
                  ),
                  backgroundColor: Colors.indigo,
                  onPressed: () async {
                    controller.updateNote(note);
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
                                    border: Border.all(
                                        width: 1, color: AppColors.blue)),
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
                                margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                child: TextFormField(
                                  controller: controller.titleController,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 28,
                                    wordSpacing: 3,
                                    height: 1.5,
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
                                margin: const EdgeInsets.only(left: 4, top: 10),
                                child: TextFormField(
                                  controller: controller.bodyController,
                                  maxLines: 500,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 22,
                                    wordSpacing: 3,
                                    height: 1.5,
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
                        margin: const EdgeInsets.only(right: 10),
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
                          'Update note',
                          style: GoogleFonts.marckScript(
                            fontSize: 35,
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
