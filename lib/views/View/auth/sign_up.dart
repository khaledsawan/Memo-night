import 'package:flutter/cupertino.dart';
import 'package:mnv2/views/mobile_view/auth/login_m.dart';
import 'package:sizer/sizer.dart';

import '../../mobile_view/auth/signup_m.dart';
import '../../web_view/auth/signup_w.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (context,builder){
      return builder.maxWidth>800?
      const SignUpW():const SignUpM();

    });
  }
}
