import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mnv2/views/mobile_view/auth/login_m.dart';
import '../../../logic/Controllers/Auth_Controller.dart';
import '../../web_view/auth/login_w.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
   double width= MediaQuery.of(context).size.width;
   Get.lazyPut(() => AuthController());

   return LayoutBuilder(builder: (context,builder){
    return builder.maxWidth>800?
     const LoginW():const LoginM();

  });
  }
}
