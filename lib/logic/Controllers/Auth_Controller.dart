import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Database/Services/auth_services.dart';
import '../../routes/routes.dart';


class AuthController extends GetxController {

  @override
  void onInit() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        Get.offAllNamed(AppRoutes.login);
        Get.snackbar('warning', 'User changes please login again',
            colorText: Colors.red);
      }
    });
    super.onInit();
  }

  doLogout() async {
    if (AuthService.logout() == true) {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.offAllNamed(AppRoutes.login);
      await FirebaseAuth.instance.signOut();
    }
  }
}
