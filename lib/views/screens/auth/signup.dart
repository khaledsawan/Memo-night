import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memo_night/logic/Controllers/Register_Controller.dart';
import 'package:memo_night/views/screens/auth/login.dart';
import '../../../routes/routes.dart';
import 'dart:async';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>  with TickerProviderStateMixin{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  RegisterController controller = Get.find();
  List<Color> colorList = [
    const Color(0xff171B70),
    const Color(0xff410D75),
    const  Color(0xff032340),
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
    controller.nameController=nameController;
    controller.phoneController=phoneController;
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: AnimatedContainer(duration:const Duration(seconds: 2),
        onEnd: () {
          setState(
                () {
              index = index + 1;
              bottomColor = colorList[index % colorList.length];
              topColor = colorList[(index + 1) % colorList.length];
            },
          );
        },
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: [bottomColor, topColor],
          ),
        ),
        child: Form(
          key: controller.registerForKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: height*0.1,),
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    'SignUp'.tr,
                    style: GoogleFonts.marckScript(fontSize: 75,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xDA00BBFF),)
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: controller.nameController,
                            onSaved: (v) {
                              controller.name = v!;
                            },
                            validator: (v) {
                              return controller.validateName(v!);
                            },
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Name'.tr,
                              prefixIcon: const Padding(
                                padding: EdgeInsets
                                    .only(), // add padding to adjust icon
                                child: Icon(
                                  Icons.person,
                                  color: Color(0xFF7423A8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: controller.emailController,
                          onSaved: (v) {
                            controller.email = v!;
                          },
                          // validator: (v) {
                          //   return controller.validateEmail(v!);
                          // },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Email'.tr,
                            prefixIcon: const Padding(
                              padding:
                              EdgeInsets.only(), // add padding to adjust icon
                              child: Icon(
                                Icons.mail,
                                color: Color(0xFF7423A8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        margin: const EdgeInsets.only(
                            left: 0, top: 0, right: 0, bottom: 10.0),
                        child: TextFormField(
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (v) {
                            controller.email = v!;
                          },
                          validator: (v) {
                            return controller.validatePassword(v!);
                          },
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Password'.tr,
                            prefixIcon: const Padding(
                              padding:
                              EdgeInsets.only(), // add padding to adjust icon
                              child: Icon(
                                Icons.lock_open,
                                color: Color(0xFF7423A8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        margin: const EdgeInsets.only(
                            left: 0, top: 0, right: 0, bottom: 10.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onSaved: (v) {
                            controller.phone = v!;
                          },
                          validator: (v) {
                            return controller.validatePhone(v!);
                          },
                          controller: controller.phoneController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Phone Number'.tr,
                            prefixIcon: const Padding(
                              padding:
                              EdgeInsets.only(), // add padding to adjust icon
                              child: Icon(
                                Icons.phone_android,
                                color: Color(0xFF7423A8),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                          await controller.register();
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
                              'Register',
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
                                text: 'You have Account?',
                                style: const TextStyle(
                                    color: Color(0xFF7423A8), fontSize: 18),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Sign In',
                                      style: const TextStyle(
                                          color: Colors.blueAccent, fontSize: 18),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(AppRoutes.login);
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
                            color:Colors.white,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}



