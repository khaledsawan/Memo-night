import 'package:get/get.dart';
import 'package:memo_night/logic/Controllers/edit_note_controller.dart';
import '../Controllers/Auth_Controller.dart';

class EditNotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>AuthController());
    Get.lazyPut(()=>EditNoteController());
  }
}