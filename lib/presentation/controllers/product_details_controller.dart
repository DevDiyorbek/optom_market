import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  var productQuantity = 1.obs; // Observing quantity change

  void increaseQuantity() {
    productQuantity++;
  }

  void decreaseQuantity() {
    if (productQuantity > 1) {
      productQuantity--;
    }
  }
}
