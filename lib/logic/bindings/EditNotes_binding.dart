import 'package:get/get.dart';
import '../Controllers/Auth_Controller.dart';
import '../Controllers/edit_note_controller.dart';

class EditNotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>AuthController());
    Get.lazyPut(()=>EditNoteController());
  }
}