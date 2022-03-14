import 'package:get/get.dart';
import 'package:memo_night/logic/Controllers/Auth_Controller.dart';
import 'package:memo_night/logic/Controllers/Notes_Controller.dart';



class Notes_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Notes_Controller());
    Get.put(AuthController());
    }
}