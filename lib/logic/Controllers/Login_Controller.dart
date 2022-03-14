import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memo_night/Databease/Services/auth_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:memo_night/views/screens/home_page/Notes.dart';





class LoginController extends GetxController {
  var isLoading = false.obs;
  final loginForKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  String email = '', password = '';
  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value))
      return "email not validate";
    else
      return null;
  }

  String? validatePassword(String value) {
    if (value.length <= 6)
      return "short password";
    else
      return null;
  }

  DoLogin_email_password() async {
    bool invalidate = loginForKey.currentState!.validate();
    if (invalidate) {
      isLoading(true);
      try {
        UserCredential? data = await AuthService.login(
            email: emailController.text, password: passwordController.text);
        if (data != null) {
          Get.off(()=>Notes());
        }
      } finally {
        isLoading(false);
      }
    }
    passwordController.text='';
  }


  DoLogin_google() async {
    isLoading(true);
    try {
      UserCredential data = await AuthService.signInWithGoogle();
      if(data!=null)
        { Get.off(()=>Notes());
        Get.snackbar('successful','');}
      else{Get.dialog(const Text('filed signup'));}

    } finally {
      isLoading(false);
    }
  }

  DoLogin_facebook() async {
    isLoading(true);
    try {
      var data = await AuthService.signInWithGoogle();
      if(data!=null)
      { Get.off(()=>Notes());
      Get.dialog(const Text('successful'));}
      else{Get.dialog(const Text('filed signup'));}
      print('data.credential');
    } finally {
      isLoading(false);
    }
  }
}
