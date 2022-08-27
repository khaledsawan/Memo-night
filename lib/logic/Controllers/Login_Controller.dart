import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import '../../Database/Services/auth_services.dart';
import '../../routes/routes.dart';
import '../../views/mobile_view/crud/index_m.dart';

class LoginController extends GetxController with GetSingleTickerProviderStateMixin {
  var isLoading = false.obs;
  final loginForKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  String email = '', password = '';

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
        Get.offAll(() => IndexM());
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
      Future<UserCredential> signInWithFacebook() async {
        // Trigger the sign-in flow
        final LoginResult loginResult = await FacebookAuth.instance.login();

        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

        // Once signed in, return the UserCredential
        return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      }
    } finally {
      isLoading(false);
    }
    update();

  }
}
