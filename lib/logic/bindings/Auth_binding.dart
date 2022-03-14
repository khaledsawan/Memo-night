import 'package:get/get.dart';
import '../Controllers/Auth_Controller.dart';

class Auth_binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>AuthController());
  }
}