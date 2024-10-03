import 'package:optom_market/data/models/product_model.dart';

class OrderResponse {
  final int id;
  final String orderDate;
  final double orderAmount;
  final String orderStatus;
  final String shippingAddress;
  final List<OrderDetail> orderDetails;
  final UserInfo userInfo;

  OrderResponse({
    required this.id,
    required this.userInfo,
    required this.orderDate,
    required this.orderAmount,
    required this.orderStatus,
    required this.shippingAddress,
    required this.orderDetails,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      id: json['id'],
      userInfo: UserInfo.fromJson(json['user_info']),
      orderDate: json['order_date'],
      orderAmount: json['order_amount'].toDouble(),
      orderStatus: json['order_status'],
      shippingAddress: json['shipping_address'],
      orderDetails: (json['order_details'] as List)
          .map((detail) => OrderDetail.fromJson(detail))
          .toList(),
    );
  }
}

class UserInfo {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final int? telegramId;
  final String? username;

  UserInfo({
    required this.firstName,
    this.lastName,
    required this.phoneNumber,
    required this.telegramId,
    required this.username,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      telegramId: json['telegram_id'],
      username: json['username'],
    );
  }
}

class OrderDetail {
  final int id;
  final ProductModel product;
  final int quantity;

  OrderDetail({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
