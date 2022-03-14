import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memo_night/Databease/Services/auth_services.dart';
import 'package:memo_night/routes/routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  final registerForKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      emailController,
      phone_noController,
      passwordController;
  String name = '', email = '', password = '', phone_no = '', data = '';
  final storage = const FlutterSecureStorage();

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phone_noController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phone_noController.dispose();
    super.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "email not validate";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length <= 6) {
      return "short password most continue at list 6 characters ";
    } else {
      return null;
    }
  }

  String? validatephone_no(String value) {
    if (!GetUtils.isPhoneNumber(value)) {
      return "enter phone number ";
    } else
      return null;
  }

  String? validatename(String value) {
    if (value.length < 2) {
      return "short name ";
    } else {
      return null;
    }
  }

  Future DoRegister() async {
    bool invalidate = registerForKey.currentState!.validate();
    if (invalidate) {
      isLoading(true);
      try {
        UserCredential data = await AuthService.register(
          email: emailController.text,
          password: passwordController.text,
        );
        if (data != null) {
          FirebaseFirestore.instance.collection('User').add({
            "email": emailController.text,
            "password": passwordController.text,
            "username":nameController.text,
            "phoneNumber":phone_noController.text
          });
          Get.off(AppRoutes.notes);
          Get.snackbar('welcome back', '');
        } else {
          Get.dialog(Text('filed signup'));
        }
      } finally {
        isLoading(false);
      }
    }
  }
}
