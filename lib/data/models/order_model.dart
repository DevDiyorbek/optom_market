class OrderModel {
  final List<int> productIds; // List of product IDs in the order
  final List<int> quantities; // Corresponding quantities for each product
  final String shippingAddress; // Shipping address for the order
  final String customerName; // Name of the customer placing the order

  OrderModel({
    required this.productIds,
    required this.quantities,
    required this.shippingAddress,
    required this.customerName,
  });

  // Convert OrderModel to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'productIds': productIds,
      'quantities': quantities,
      'shippingAddress': shippingAddress,
      'customerName': customerName,
    };
  }

  // Create an OrderModel from a JSON map
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      productIds: List<int>.from(json['productIds']),
      quantities: List<int>.from(json['quantities']),
      shippingAddress: json['shippingAddress'] as String,
      customerName: json['customerName'] as String,
    );
  }
}
