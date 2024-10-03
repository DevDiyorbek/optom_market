import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:optom_market/data/datasources/auth_service.dart';
import 'package:optom_market/utility/LogServices.dart';
import '../../utility/secure_storage.dart';
import '../models/OrderResponce.dart';

class OrderService {
  final String baseUrl = 'https://api.sodiqdev.cloud';
  final SecureStorage _secureStorage = SecureStorage();
  AuthService authService = AuthService();

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

    //
    // if (response.statusCode == 401){
    //   authService.refreshAccessToken();
    // } else if (response.statusCode == 403){
    //   authService.navigateToTelegramBot();
    // }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final SecureStorage _secureStorage = SecureStorage();
      var name = await _secureStorage.read('first_name');
      var token = await _secureStorage.read("access_token");
      LogService.w("Item sent with address : $shippingAddress and name $name and token $token");
      return OrderResponse.fromJson(jsonDecode(response.body));

    } else {
      throw Exception('Failed to send order: ${response.statusCode}');
    }
  }

  Future<List<OrderResponse>> orderHistory() async {
    final accessToken = await _secureStorage.read('access_token');
    if (accessToken == null) {
      throw Exception('Access token not found');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/orders/?page=1'),
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );

    // if (response.statusCode == 401) {
    //   authService.refreshAccessToken();
    // } else if (response.statusCode == 403) {
    //   authService.navigateToTelegramBot();
    // }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> items = data['items'];
      return items.map((item) => OrderResponse.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch order history: ${response.statusCode}');
    }
  }

}
