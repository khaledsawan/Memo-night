import 'package:get/get.dart';


class Notes_Controller extends GetxController {
  int? id;
  void dependencies() {
    Get.lazyPut(() => Notes_Controller());

  }
  // getProductsController() async {
  //   var products = await Products_Services.Getproducts();
  //   return products;
  //   //////////test
  // }

  // getmyProductsController() async {
  //   var products = await Products_Services.Getmyproducts();
  //   return products;
  //   ///////////test
  // }
  //
  // deleteproduct(id) async {
  //   await Products_Services.DeleteProduct(id: id);
  //   ////test
  // }
}