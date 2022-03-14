import 'package:get/get.dart';
import 'package:memo_night/logic/Controllers/Auth_Controller.dart';
import 'package:memo_night/logic/Controllers/AddNote_Controller.dart';


class AddNote_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNoteController());
   // Get.put(AuthController());
  }
}