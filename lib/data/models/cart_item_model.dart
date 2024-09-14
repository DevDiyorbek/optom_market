import 'package:optom_market/data/models/product_model.dart';

class CartItemModel {
  final int id;
  final ProductModel product;
  final int quantity;
  final int itemCost;
  final DateTime createdDate;

  CartItemModel({
    required this.id,
    required this.product,
    required this.quantity,
    required this.itemCost,
    required this.createdDate,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
      itemCost: json['item_cost'],
      createdDate: DateTime.parse(json['created_date']),
    );
  }
}
