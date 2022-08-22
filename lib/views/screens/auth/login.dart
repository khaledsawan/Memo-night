import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:memo_night/Databease/Services/auth_services.dart';
import 'package:memo_night/logic/Controllers/Login_Controller.dart';
import 'package:memo_night/routes/routes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService authService = AuthService();
  LoginController controller = Get.find();
  List<Color> colorList = [
    const Color(0xff171B70),
    const Color(0xff410D75),
    const Color(0xff032340),
    const Color(0xff050340),
    const Color(0xff2C0340),
  ];
  List<Alignment> alignmentList = [Alignment.topCenter, Alignment.bottomCenter];
  int index = 0;
  Color bottomColor = const Color(0xff092646);
  Color topColor = const Color(0xff410D75);
  Alignment begin = Alignment.bottomCenter;
  Alignment end = Alignment.topCenter;
  @override
  void initState() {
    super.initState();
    controller.emailController=emailController;
    controller.passwordController=passwordController;
    Timer(
      const Duration(microseconds: 0),
      () {
        setState(
          () {
            bottomColor =const Color(0xff33267C);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AnimatedContainer(
        duration:const Duration(seconds: 2),
        onEnd: () {
          setState(
            () {
              index = index + 1;
              bottomColor = colorList[index % colorList.length];
              topColor = colorList[(index + 1) % colorList.length];
            },
          );
        },
        //
        // TextStyle(
        //   fontSize: 50,
        //   fontStyle: FontStyle.italic,
        //   color: Color(0xDA00BBFF),
        // )
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: [bottomColor, topColor],
          ),
        ),
        child: Center(
          child: Form(
            key: controller.loginForKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        'Login'.tr,
                        style:  GoogleFonts.marckScript(fontSize: 75,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xDA00BBFF),)
                      ),
                    ),
                  ),
                  SizedBox(height: height*0.1,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        return controller.validateEmail(v!);
                      },
                      onSaved: (v) {
                        controller.emailController != v;
                      },
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Email'.tr,
                        prefixIcon: const Padding(
                          padding:
                              EdgeInsets.only(), // add padding to adjust icon
                          child: Icon(
                            Icons.mail_outline,
                            color: Color(0xFF7423A8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    margin: const EdgeInsets.only(
                        left: 0, top: 0, right: 0, bottom: 6.0),
                    child: TextFormField(
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) {
                        return controller.validatePassword(v!);
                      },
                      onSaved: (v) {
                        controller.passwordController != v;
                      },
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(),
                          child: Icon(
                            Icons.lock_open,
                            color: Color(0xFF7423A8),
                          ),
                        ),
                        labelText: 'Password'.tr,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // TextButton(
                  //  // onPressed: _resetPassword(context),
                  //
                  //   onPressed: () {  },
                  //   child: const Text('Forgot password?'),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => controller.isLoading.value == true
                        ? const Center(child: CircularProgressIndicator())
                        : const Text(""),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller.doLoginEmailPassword();
                    },
                    child: Container(
                      width: width * 0.4,
                      height: height * 0.075,
                      decoration: BoxDecoration(
                          color: const Color(0xFF7423A8),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              width: 1, color: const Color(0xDA00BBFF))),
                      child: const Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: AlignmentDirectional.topStart,
                    width: width,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: const TextStyle(
                                color: Color(0xFF7423A8), fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign up',
                                  style: const TextStyle(
                                      color: Colors.blueAccent, fontSize: 18),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(AppRoutes.signup);
                                    })
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                    alignment: Alignment.center,
                    child: Text(
                      'OR'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 55,
                          margin: const EdgeInsets.all(4),
                          child: IconButton(
                            icon:
                                Image.asset('images/assets/icons8google96.png'),
                            color: Colors.white,
                            onPressed: () {
                              controller.doLoginGoogle();
                              // google().signInWithGoogle();
                            },
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 55,
                          margin: const EdgeInsets.all(4),
                          child: IconButton(
                            icon: Image.asset('images/assets/facebook96.jpg'),
                            color: Colors.white,
                            onPressed: () {
                              controller.doLoginFacebook();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
