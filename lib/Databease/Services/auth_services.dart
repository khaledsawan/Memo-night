import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../model/response_model.dart';

class AuthService {

  static Future<ResponseModel> register({
    required email,
    required password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
      return ResponseModel(massage: 'Registration in done', isSuccessful: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("try again", 'The password provided is too weak.');
        return ResponseModel(massage: '', isSuccessful: false);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("try again", 'The account already exists for that email.');
        return ResponseModel(massage: '', isSuccessful: false);
      }
    } catch (e) {
      return ResponseModel(massage: e.toString(), isSuccessful: false);
    }
    return ResponseModel(massage: '', isSuccessful: false);
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<UserCredential?> login(
      {required email, required password}) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("try again", 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar("try again", 'Wrong password provided for that user.');
      }
    } catch (e) {
      GetSnackBar(
        message: e.toString(),
      );

      return userCredential = false as UserCredential;
    }
    return null;
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  static Future<bool> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    if (FirebaseAuth.instance.currentUser == null) {
      return true;
    } else {
      return false;
    }
  }
}
