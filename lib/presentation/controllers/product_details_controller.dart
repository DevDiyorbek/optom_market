import 'package:get/get.dart';
import 'package:optom_market/utility/LogServices.dart';

class ProductDetailsController extends GetxController {
  var productQuantity = 1.obs;

  @override
  void onInit() {
    LogService.w("Entered");
    super.onInit();
  }

  void increaseQuantity() {
    productQuantity++;
  }

  void decreaseQuantity() {
    if (productQuantity > 1) {
      productQuantity--;
    }
  }

  void resetQuantity() {
    productQuantity.value = 1;
  }
}
