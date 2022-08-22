import 'package:get/get.dart';
import 'package:memo_night/logic/Controllers/AddNote_Controller.dart';


class AddNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNoteController());
  }
}