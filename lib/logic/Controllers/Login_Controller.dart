import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memo_night/Databease/Services/auth_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:memo_night/routes/routes.dart';
import '../../views/screens/crud/index.dart';

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  var isLoading = false.obs;
  final loginForKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  String email = '', password = '';
  final storage = const FlutterSecureStorage();

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "email not validate";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length <= 6) {
      return "short password";
    } else {
      return null;
    }
  }

  doLoginEmailPassword() async {
    bool invalidate = loginForKey.currentState!.validate();
    if (invalidate) {
      isLoading(true);
      try {
        UserCredential? data = await AuthService.login(
            email: emailController.text, password: passwordController.text);
        if (data != null) {
         Get.offNamed(AppRoutes.notes);
        }
      } finally {
        isLoading(false);
      }
    }
    passwordController.text = '';
    update();

  }

  doLoginGoogle() async {
    isLoading(true);
    try {
      UserCredential data = await AuthService.signInWithGoogle();
      if (!data.isNull) {
        Get.offAll(() => Index());
        Get.snackbar('successful', '');
      } else {
        Get.dialog(const Text('filed signup'));
      }
    } finally {
      isLoading(false);
    }
    update();

  }

  doLoginFacebook() async {
    isLoading(true);
    try {
      var data = await AuthService.signInWithGoogle();
      if (data != null) {
        Get.off(() => const Index());
        Get.dialog(const Text('successful'));
      } else {
        Get.dialog(const Text('filed signup'));
      }
      print('data.credential');
    } finally {
      isLoading(false);
    }
    update();

  }
}
