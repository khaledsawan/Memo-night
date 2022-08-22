import 'package:get/get.dart';
import 'package:memo_night/logic/Controllers/Login_Controller.dart';


class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}