import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:mnv2/views/mobile_view/auth/login_m.dart';
import 'package:sizer/sizer.dart';

import '../../mobile_view/crud/index_m.dart';
import '../../web_view/auth/login_w.dart';
import '../../web_view/crud/index_w.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrain) {
      return constrain.maxWidth > 800 ? IndexW() : IndexM();
    });
  }
}
