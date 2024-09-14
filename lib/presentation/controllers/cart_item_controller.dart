import 'package:get/get.dart';
import 'package:optom_market/presentation/controllers/cart_controller.dart';

class CartItemController extends GetxController {
  CartController cartController = CartController();
  var productQuantity = 1.obs; // Default value

  CartItemController(int initialQuantity) {
    productQuantity.value = initialQuantity;
  }

  void increaseQuantity() {
    productQuantity++;
  }

  void decreaseQuantity() {
    if (productQuantity > 1) {
      productQuantity--;
    }
  }

  void onRemove(int cartItemId) async {
    try {
      cartController.removeCartItem(cartItemId);
    } catch (error) {
      print("Error removing cart item: $error");
    }
  }
}
