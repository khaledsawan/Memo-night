

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:memo_night/logic/Controllers/AddNote_Controller.dart';
import 'package:memo_night/logic/Controllers/Register_Controller.dart';
import 'package:memo_night/logic/Controllers/edit_note_controller.dart';

import '../logic/Controllers/Auth_Controller.dart';
import '../logic/Controllers/Login_Controller.dart';

Future<void> init() async {
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => RegisterController());
  Get.lazyPut(() => AddNoteController());
  Get.lazyPut(() => EditNoteController());
}
