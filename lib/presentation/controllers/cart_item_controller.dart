import 'package:get/get.dart';
import 'package:optom_market/presentation/controllers/cart_controller.dart';
import '../../data/models/cart_items_model.dart';

class CartItemController extends GetxController {
  final CartController cartController = Get.find<CartController>(); // Get the existing instance
  var productQuantity = 1.obs; // Default value
  final CartItemsModel cartItem; // Reference to the specific cart item

  CartItemController(this.cartItem, int initialQuantity) {
    productQuantity.value = initialQuantity;
  }

  void increaseQuantity() {
    productQuantity++;
    cartController.updateCartItemQuantity(cartItem.id, productQuantity.value);
  }

  void decreaseQuantity() {
    if (productQuantity > 1) {
      productQuantity--;
      cartController.updateCartItemQuantity(cartItem.id, productQuantity.value);
    }
  }

  void onRemove() async {
    try {
      cartController.removeCartItem(cartItem.id);
    } catch (error) {
      print("Error removing cart item: $error");
    }
  }
}
