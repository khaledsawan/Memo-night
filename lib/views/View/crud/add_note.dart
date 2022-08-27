import 'package:flutter/cupertino.dart';
import 'package:mnv2/views/web_view/crud/add_note_w.dart';
import '../../mobile_view/crud/add_note_m.dart';


class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      return constrain.maxWidth > 800 ?const AddNoteW() :const AddNoteM();
    });
  }
}
