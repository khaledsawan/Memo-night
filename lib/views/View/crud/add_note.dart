import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:mnv2/views/mobile_view/auth/login_m.dart';
import 'package:mnv2/views/web_view/crud/add_note_w.dart';
import 'package:sizer/sizer.dart';

import '../../mobile_view/crud/add_note_m.dart';
import '../../mobile_view/crud/index_m.dart';
import '../../web_view/auth/login_w.dart';
import '../../web_view/crud/index_w.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      return constrain.maxWidth > 800 ? AddNoteW() : AddNoteM();
    });
  }
}
