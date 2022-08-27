import 'package:get/get.dart';
import '../Controllers/AddNote_Controller.dart';


class AddNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNoteController());
  }
}