import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:memo_night/Databease/Services/auth_services.dart';
import 'package:memo_night/routes/routes.dart';

class AuthController extends GetxController {
  var storage = const FlutterSecureStorage();

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
      await storage.deleteAll();
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.offAllNamed(AppRoutes.login);
      await storage.deleteAll();
      await FirebaseAuth.instance.signOut();
    }
  }
}
