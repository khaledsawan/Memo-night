import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:memo_night/Databease/Services/auth_services.dart';
import 'package:memo_night/routes/routes.dart';
import 'package:memo_night/views/screens/auth/login.dart';

class AuthController extends GetxController {
   var storage = FlutterSecureStorage();

  @override
  void onInit() {
    FirebaseAuth.instance
        .userChanges()
        .listen((User? user) {
      if (user == null) {
        Get.offAll(Login());
        Get.snackbar('warning', 'User changes please login again',colorText: Colors.red);
      }
    });
    super.onInit();
  }
 // some problem
  DoLogout() async {
    if(AuthService.logout()==true)
      {
        await storage.deleteAll();
        await FirebaseAuth.instance.signOut();
        Get.offAll(Login());
      }
     else {Get.offAll(Login());
    await storage.deleteAll();
    await FirebaseAuth.instance.signOut();}


  }
}