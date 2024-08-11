import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/product_list_model.dart';

class ApiService {
  static const String apiUrl = 'https://api.sodiqdev.cloud/';
  static const String apiKey = 'rYKcw1YebNjfxDkVVGkbxDjqCI5ZGRbAdCm4ctCN541QwdZSPBLHSSBva5wOdIgYyVfGbmt3RwtdyDawfAN4o3KMo8i7ubEHibeDB6M6jObgv69MHKTHBnK9c8to1wYn';

  Future<ProductList> fetchProducts() async {
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
        return ProductList.fromJson(json);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<List<ProductCategory>> fetchCategories() async {
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
        return jsonList.map((json) => ProductCategory.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}

void main() {
  ApiService apiService = ApiService();
  apiService.fetchCategories();
}
