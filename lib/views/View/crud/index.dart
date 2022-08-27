import 'package:flutter/cupertino.dart';
import '../../mobile_view/crud/index_m.dart';
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
      return constrain.maxWidth > 800 ? const IndexW() : const IndexM();
    });
  }
}
