import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:memo_night/Databease/Services/auth_services.dart';
import 'package:memo_night/logic/Controllers/Login_Controller.dart';
import 'package:memo_night/routes/routes.dart';

class Login extends GetView<LoginController> {
  Login({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthService auth_service = AuthService();
  LoginController loginController = Get.find();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Form(
          key: controller.loginForKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    margin: const EdgeInsets.all(10),
                    child: Text(
                      'Login'.tr,
                      style: const TextStyle(
                        fontSize: 50,
                        fontStyle: FontStyle.italic,
                        color: Color(0xDA00BBFF),
                      ),
                    ),
                  ),
                ),
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
                Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      shape: const StadiumBorder(side: BorderSide()),
                      color: const Color(0xFF2A0445),
                      child: Text('Login'.tr),
                      onPressed: () {
                        controller.DoLogin_email_password();
                      },
                    )),
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
                          icon: Image.asset('images/assets/icons8google96.png'),
                          color: Colors.white,
                          onPressed: () {
                            controller.DoLogin_google();
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
                            controller.DoLogin_facebook();
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
    );
  }

  //  _resetPassword( context ) async {
  //   String? email;
  //   await showDialog(
  //     builder: (context) {
  //       return AlertDialog(
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Send'),
  //           ),
  //         ],
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text('Enter your email'),
  //             const SizedBox(height: 20),
  //             TextFormField(
  //               onChanged: (value) {
  //                 email = value;
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //     context: context,
  //   );
  //
  //   if (email != null) {
  //     try {
  //       await auth.sendPasswordResetEmail(email: email!);
  //       Get.snackbar('email send', 'please chake your Email');
  //     } catch (e) {
  //       Get.snackbar('error', 'Error resetting');
  //     }
  //   }
  // }
}
