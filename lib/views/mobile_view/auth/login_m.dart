import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:sizer/sizer.dart';

import '../../../Database/Services/auth_services.dart';
import '../../../logic/Controllers/Login_Controller.dart';
import '../../../routes/routes.dart';

class LoginM extends StatefulWidget {
  const LoginM({Key? key}) : super(key: key);

  @override
  State<LoginM> createState() => _LoginMState();
}

class _LoginMState extends State<LoginM> with TickerProviderStateMixin {
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
    controller.emailController = emailController;
    controller.passwordController = passwordController;
    Timer(
      const Duration(microseconds: 0),
      () {
        setState(
          () {
            bottomColor = const Color(0xff33267C);
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
        duration: const Duration(seconds: 2),
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
                      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0.1.h),
                      child: Text('Login'.tr,
                          style: GoogleFonts.marckScript(
                            fontSize: 75.sp,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xDA00BBFF),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: height.h * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.all(2.h),
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
                        labelStyle: TextStyle(fontSize: 14.sp),
                        prefixIcon:  Padding(
                          padding:
                              EdgeInsets.only(), // add padding to adjust icon
                          child: Icon(
                            size: 20.sp,
                            Icons.mail_outline,
                            color: Color(0xFF7423A8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(2.h),
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
                        prefixIcon:  Padding(
                          padding: EdgeInsets.only(),
                          child: Icon(

                            Icons.lock_open,
                            color: Color(0xFF7423A8),
                            size: 20.sp,
                          ),
                        ),
                        labelStyle: TextStyle(fontSize: 14.sp),
                        labelText: 'Password'.tr,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   // height: 1.h,
                  // ),
                  // TextButton(
                  //  // onPressed: _resetPassword(context),
                  //
                  //   onPressed: () {  },
                  //   child: const Text('Forgot password?'),
                  // ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  Obx(
                    () => controller.isLoading.value == true
                        ? const Center(child: CircularProgressIndicator())
                        : const Text(""),
                  ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  GestureDetector(
                    onTap: () async {
                      await controller.doLoginEmailPassword();
                    },
                    child: Container(
                      width: width * 0.05.h,
                      height: height * 0.01.h,
                      decoration: BoxDecoration(
                          color: const Color(0xFF7423A8),
                          borderRadius: BorderRadius.circular(1.5.h),
                          border: Border.all(
                              width: 1, color: const Color(0xDA00BBFF))),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(4.w,2.h, 4.w, 4.h),
                    alignment: AlignmentDirectional.topStart,
                    width: width,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(
                                color: const Color(0xFF7423A8),
                                fontSize: 14.sp),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Sign up',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16.sp),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(AppRoutes.signup);
                                    })
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(1.w, 0.h, 1.w, 1.h),
                    alignment: Alignment.center,
                    child: Text(
                      'OR'.tr,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(1.w, 0.h, 1.w, 1.h),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 15.w,
                          height: 15.h,
                          margin: EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 1.h),
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
                          width: 15.w,
                          height: 15.h,
                          margin: EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 1.h),
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
