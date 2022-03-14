import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  //////////////////////////////////////////////////
  static Future<UserCredential> register({
    required email,
    required password,
  }) async {
    late UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("try again", 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("try again", 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return userCredential;
  }

///////////////////////////////////////////////////////////////////
  static Future<UserCredential> signInWithGoogle() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = await GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

/////////////////////////////////////////////////////////////////
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
      print(e);
      return userCredential = false as UserCredential;
    }
  }

///////////////////////////////////////////////////////
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

/////////////////////////////////////////////////////
  static Future<bool> logout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    if (FirebaseAuth.instance.currentUser == null)
      return true;
    else
      return false;
  }
}
