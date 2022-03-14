import 'package:get/get.dart';
import 'package:memo_night/logic/Controllers/AddNote_Controller.dart';

import '../Controllers/Auth_Controller.dart';

class EditNotes_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNoteController());
    Get.lazyPut(()=>AuthController());
  }
}