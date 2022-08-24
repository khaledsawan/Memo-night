import 'package:get/get.dart';
import '../logic/Controllers/AddNote_Controller.dart';
import '../logic/Controllers/Auth_Controller.dart';
import '../logic/Controllers/Login_Controller.dart';
import '../logic/Controllers/Register_Controller.dart';
import '../logic/Controllers/edit_note_controller.dart';

Future<void> init() async {
  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => RegisterController());
  Get.lazyPut(() => AddNoteController());
  Get.lazyPut(() => EditNoteController());
}
