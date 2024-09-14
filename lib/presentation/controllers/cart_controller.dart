import 'package:get/get.dart';
import '../../data/datasources/cart_service.dart';
import '../../data/models/cart_items_model.dart';
class CartController extends GetxController {
  final CartService _cartService = CartService();
  var cartItems = <CartItemsModel>[].obs;

  @override
  void onInit() {
    fetchCartItems();
    refreshCartItems();
    super.onInit();
  }

  void fetchCartItems() async {
    try {
      List<CartItemsModel> items = await _cartService.getCartItems();
      cartItems.assignAll(items);
    } catch (error) {
      print('Error fetching cart items: $error');
    }
  }

  void refreshCartItems() async {
    try {
      List<CartItemsModel> items = await _cartService.getCartItems();
      cartItems.value = items;
    } catch (error) {
      print('Error refreshing cart items: $error');
    }
  }


  void removeCartItem(int cartItemId) async {
    try {
      await _cartService.removeItemFromCart(cartItemId);
      cartItems.removeWhere((item) => item.id == cartItemId);
      refreshCartItems();
    } catch (error) {
      print('Error removing cart item: $error');
    }
  }
}
