import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import '../../Databease/Services/auth_services.dart';
import '../../Databease/model/response_model.dart';
import '../../routes/routes.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  final registerForKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      emailController,
      phoneController,
      passwordController;
  String name = '', email = '', password = '', phone = '';

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
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

  String? validatePhone(String value) {
    if (!GetUtils.isPhoneNumber(value)) {
      return "enter phone number ";
    } else {
      return null;
    }
  }

  String? validateName(String value) {
    if (value.length < 2) {
      return "short name ";
    } else {
      return null;
    }
  }

  Future register() async {
    bool invalidate = registerForKey.currentState!.validate();
    if (invalidate) {
      isLoading(true);
      try {
        ResponseModel data = await AuthService.register(
          email: emailController.text,
          password: passwordController.text,
        );
        if (data.isSuccessful!) {
          FirebaseFirestore.instance.collection('User').add({
            "email": emailController.text,
            "password": passwordController.text,
            "username": nameController.text,
            "phoneNumber": phoneController.text
          });
          Get.offAllNamed(AppRoutes.notes);
          Get.snackbar(' Welcome ', '');
        } else {
          Get.dialog(Text(data.massage!.toString()));
        }
      } finally {
        isLoading(false);
      }
    }
  }

  doLoginGoogle() async {
    isLoading(true);
    try {
      UserCredential data = await AuthService.signInWithGoogle();
      if (!data.isNull) {
        Get.offAllNamed(AppRoutes.login);
        Get.snackbar('successful', '');
      } else {
        Get.dialog(const Text('filed signup'));
      }
    } finally {
      isLoading(false);
    }
  }

  doLoginFacebook() async {
    isLoading(true);
    try {

        // Trigger the sign-in flow
        final LoginResult loginResult = await FacebookAuth.instance.login();

        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

        // Once signed in, return the UserCredential
        return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    } finally {
      isLoading(false);
    }
  }
}
