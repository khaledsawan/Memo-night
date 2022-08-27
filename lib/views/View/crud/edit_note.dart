import 'package:flutter/cupertino.dart';
import '../../../Database/model/note_model.dart';
import '../../mobile_view/crud/edit_notes_m.dart';
import '../../web_view/crud/edit_notes_w.dart';

class EditNote extends StatefulWidget {
  late NoteModel note;

  EditNote({Key? key, required this.note}) : super(key: key);
  @override
  State<EditNote> createState() => _EditNoteState(note: note);
}

class _EditNoteState extends State<EditNote> {
  late NoteModel note;

  _EditNoteState({required this.note});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      return constrain.maxWidth > 800
          ? EditNoteW(
              note: note,
            )
          : EditNoteM(
              note: note,
            );
    });
  }
}
