import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:optom_market/utility/LogServices.dart';
import '../../utility/secure_storage.dart';
import '../models/OrderResponce.dart';

class OrderService {
  final String baseUrl = 'https://api.sodiqdev.cloud';
  final SecureStorage _secureStorage = SecureStorage();

  Future<OrderResponse> sendOrders({required String shippingAddress}) async {
    final accessToken = await _secureStorage.read('access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/orders/'),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'shipping_address': shippingAddress,
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      LogService.w("Item sent with address : $shippingAddress");
      return OrderResponse.fromJson(jsonDecode(response.body));

    } else {
      throw Exception('Failed to send order: ${response.statusCode}');
    }
  }
}
