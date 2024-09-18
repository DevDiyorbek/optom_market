import 'package:get/get.dart';
import 'package:optom_market/presentation/pages/cart_pages/checkout_widget.dart';
import '../../data/datasources/cart_service.dart';
import '../../data/models/cart_items_model.dart';
import '../../utility/secure_storage.dart';

class CartController extends GetxController {
  final CartService _cartService = CartService();
  var cartItems = <CartItemsModel>[].obs;
  final SecureStorage _secureStorage = SecureStorage();
  String deliveryAddress = "";

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

  Future<String> getInitialAddress() async {
    deliveryAddress = (await _secureStorage.read('address'))!;
    return deliveryAddress;
  }

  void refreshCartItems() async {
    try {
      List<CartItemsModel> items = await _cartService.getCartItems();
      cartItems.value = items; // Refresh the list
    } catch (error) {
      print('Error refreshing cart items: $error');
    }
  }

  void removeCartItem(int cartItemId) async {
    try {
      await _cartService.removeItemFromCart(cartItemId);
      cartItems.removeWhere((item) => item.id == cartItemId);
      refreshCartItems(); // Refresh the cart items after deletion
    } catch (error) {
      print('Error removing cart item: $error');
    }
  }

  void updateCartItemQuantity(int cartItemId, int newQuantity) {
    final index = cartItems.indexWhere((item) => item.id == cartItemId);
    if (index != -1) {
      final currentItem = cartItems[index];
      cartItems[index] = CartItemsModel(
        id: currentItem.id,
        product: currentItem.product,
        quantity: newQuantity,
        itemCost: currentItem.itemCost,
        createdDate: currentItem.createdDate,
      );
    } else {
      print("Item with id $cartItemId not found.");
    }
  }

  double calculateTotalPrice() {
    return cartItems.fold(
        0.0, (total, item) => total + (item.product.price * item.quantity));
  }
}
