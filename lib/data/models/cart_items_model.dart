import 'product_model.dart';

class CartItemsModel {
  final int id;
  final ProductModel product;
  int quantity;
  final double itemCost;
  final String createdDate;

  CartItemsModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.itemCost,
    required this.createdDate,
  });

  factory CartItemsModel.fromJson(Map<String, dynamic> json) {
    return CartItemsModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      itemCost: json['item_cost'].toDouble(),
      createdDate: json['created_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'item_cost': itemCost,
      'created_date': createdDate,
    };
  }
}
