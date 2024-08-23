import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/order_model.dart';
import '../models/product_list_model.dart';

class ApiService {
  static const String apiUrl = 'https://api.sodiqdev.cloud/';
  static const String apiKey =
      'rYKcw1YebNjfxDkVVGkbxDjqCI5ZGRbAdCm4ctCN541QwdZSPBLHSSBva5wOdIgYyVfGbmt3RwtdyDawfAN4o3KMo8i7ubEHibeDB6M6jObgv69MHKTHBnK9c8to1wYn';
  static const String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5OTg5NDMxMTY2MjQiLCJ1c2VyX2lkIjoxMDIsImV4cCI6MTcyMjg2MjA4NywidG9rZW5fdHlwZSI6ImFjY2VzcyJ9.nPWT97l5BCWRWhNPCS995KLCljG7gQEM4saXJe-RHvI';

  Future<ProductListModel> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('${apiUrl}products'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'x-api-key=$apiKey',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return ProductListModel.fromJson(json);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<List<ProductCategoryModel>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('${apiUrl}products/category'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'x-api-key=$apiKey',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((json) => ProductCategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }

  Future<void> postOrder(OrderModel order) async {
    try {
      final response = await http.post(
        Uri.parse('${apiUrl}orders'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          order.toJson(),
        ),
      );

      if (response.statusCode == 201) {
        // Order successfully created
        print('Order placed successfully!');
      } else {
        throw Exception(
            'Failed to place order. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error posting order: $e');
    }
  }
}

void main() {
  ApiService apiService = ApiService();
  apiService.fetchCategories();
}
