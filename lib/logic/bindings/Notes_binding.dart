import 'package:get/get.dart';
import 'package:memo_night/logic/Controllers/Auth_Controller.dart';
import 'package:memo_night/logic/Controllers/edit_note_controller.dart';



class NotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditNoteController());
    Get.put(AuthController());
    }
}