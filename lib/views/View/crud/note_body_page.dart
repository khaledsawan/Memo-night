import 'package:flutter/cupertino.dart';
import 'package:mnv2/Database/model/note_model.dart';
import '../../mobile_view/crud/note_body_page_m.dart';
import '../../web_view/crud/note_body_page_w.dart';

class NoteBodyPage extends StatefulWidget {
  late NoteModel note;

  NoteBodyPage({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteBodyPage> createState() => _NoteBodyPageState(note: note);
}

class _NoteBodyPageState extends State<NoteBodyPage> {
  late NoteModel note;
  _NoteBodyPageState({required this.note});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      return constrain.maxWidth > 800
          ? NoteBodyPageW(
              note: note,
            )
          : NoteBodyPageM(
              note: note,
            );
    });
  }
}
