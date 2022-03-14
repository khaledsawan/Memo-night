import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_night/logic/Controllers/Register_Controller.dart';


class Signup extends GetView<RegisterController> {
  Signup({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phone_noController = TextEditingController();
  RegisterController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFF111631),
          automaticallyImplyLeading: true,
          title: Title(
              title: 'Title',
              color: Colors.white,
              child: Text(
                'Sign Up'.tr,
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ))),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF0A0E21),
            ),
            child: Form(
              key: controller.registerForKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          'Sign Up'.tr,
                          style: const TextStyle(
                            fontSize: 50,
                            fontStyle: FontStyle.italic,
                            color: Color(0xDA00BBFF),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/15,
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
                            return controller.validatename(v!);
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
                          controller.phone_no = v!;
                        },
                        validator: (v) {
                          return controller.validatephone_no(v!);
                        },
                        controller: controller.phone_noController,
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
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: const Color(0xFF2A0445),
                          shape: const StadiumBorder(side: BorderSide()),
                          child: Text('Continue'.tr),
                          onPressed: () async {
                            await controller.DoRegister();
                          },
                        )),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
