import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/product_list_model.dart';

class ApiService {
  static const String apiUrl = 'https://api.sodiqdev.cloud/';
  static const String apiKey =
      'rYKcw1YebNjfxDkVVGkbxDjqCI5ZGRbAdCm4ctCN541QwdZSPBLHSSBva5wOdIgYyVfGbmt3RwtdyDawfAN4o3KMo8i7ubEHibeDB6M6jObgv69MHKTHBnK9c8to1wYn';

  Future<ProductListModel> fetchProducts(int page) async {
    try {
      final response = await http.get(
        Uri.parse('${apiUrl}products/?page=$page'),
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

  Future<ProductListModel> fetchProductsByCategory(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('${apiUrl}products?categories=$categoryId'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'x-api-key=$apiKey',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        print(ProductListModel.fromJson(json).toString());
        return ProductListModel.fromJson(json);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<ProductListModel> filterProducts({
    String? name,
    String? sortBy = 'id',
    String? sortOrder = 'desc',
    int? minPrice,
    int? maxPrice,
  }) async {
    try {
      final queryParameters = <String, String>{};

      if (name != null && name.isNotEmpty) {
        queryParameters['s'] = name;
      }
      if (sortBy != null && sortBy.isNotEmpty) {
        queryParameters['sort_by'] = sortBy;
      }
      if (sortOrder != null && sortOrder.isNotEmpty) {
        queryParameters['sort_order'] = sortOrder;
      }
      if (minPrice != null) {
        queryParameters['min_price'] = minPrice.toString();
      }
      if (maxPrice != null) {
        queryParameters['max_price'] = maxPrice.toString();
      }

      final uri = Uri.parse('${apiUrl}products/')
          .replace(queryParameters: queryParameters);

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'x-api-key=$apiKey',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return ProductListModel.fromJson(json);
      } else {
        throw Exception('Failed to filter products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error filtering products: $e');
    }
  }

}
