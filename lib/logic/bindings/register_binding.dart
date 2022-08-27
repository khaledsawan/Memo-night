import 'package:get/get.dart';
import '../Controllers/Register_Controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}