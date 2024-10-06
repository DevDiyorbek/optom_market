import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utility/LogServices.dart';
import '../../utility/secure_storage.dart';
import '../models/cart_items_model.dart';
import 'auth_service.dart';

class CartService {
  final String baseUrl = 'https://api.sodiqdev.cloud';
  final SecureStorage _secureStorage = SecureStorage();
  final AuthService _authService;

  CartService({AuthService? authService})
      : _authService = authService ?? AuthService();

  Future<void> addProductToCart(int productId, int quantity) async {
    String? accessToken = await _secureStorage.read('access_token');

    if (accessToken == null) {
      LogService.w('No access token; cannot add product to cart.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cart/add?product_id=$productId&quantity=$quantity'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      _authService.checkAccessToken(response);

      if (response.statusCode == 201) {
        LogService.w('Product added to cart successfully.');
      } else {
        LogService.e('Failed to add product to cart: ${response.body}');
      }
    } catch (e) {
      LogService.e('Error during adding product to cart: $e');
    }
  }

  Future<List<CartItemsModel>> getCartItems() async {
    String? accessToken = await _secureStorage.read('access_token');
    if (accessToken == null) {
      LogService.w('No access token; cannot retrieve cart items.');
      return [];
    }
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cart'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      _authService.checkAccessToken(response);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<CartItemsModel> cartItems = (data['cart_items'] as List)
            .map((item) => CartItemsModel.fromJson(item))
            .toList();
        return cartItems;
      } else {
        LogService.e('Failed to retrieve cart items: ${response.body}');
        return [];
      }
    } catch (e) {
      LogService.e('Error during retrieving cart items: $e');
      return [];
    }
  }

  Future<void> removeItemFromCart(int cartItemId) async {
    String? accessToken = await _secureStorage.read('access_token');

    if (accessToken == null) {
      LogService.w('No access token; cannot remove item from cart.');
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/cart/$cartItemId'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer $accessToken',
        },
      );

      _authService.checkAccessToken(response);

      if (response.statusCode == 200) {
        LogService.w('Item removed from cart successfully.');
      } else {
        LogService.e('Failed to remove item from cart: ${response.body}');
      }
    } catch (e) {
      LogService.e('Error during removing item from cart: $e');
    }
  }
}
