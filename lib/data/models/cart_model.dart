import 'cart_item_model.dart';

class Cart {
  final int id;
  final List<CartItemModel> cartItems;
  final int totalCost;

  Cart({
    required this.id,
    required this.cartItems,
    required this.totalCost,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var itemList = json['cart_items'] as List;
    List<CartItemModel> cartItemsList =
    itemList.map((i) => CartItemModel.fromJson(i)).toList();

    return Cart(
      id: json['id'],
      cartItems: cartItemsList,
      totalCost: json['total_cost'],
    );
  }
}
