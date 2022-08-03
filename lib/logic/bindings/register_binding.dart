import 'package:get/get.dart';
import 'package:memo_night/logic/Controllers/Register_Controller.dart';
class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}