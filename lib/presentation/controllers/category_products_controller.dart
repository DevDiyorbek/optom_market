import 'package:get/get.dart';
import 'package:optom_market/data/models/product_model.dart';
import '../../data/datasources/http_service.dart';

class CategoryProductsController extends GetxController {
  var productList = <ProductModel>[].obs; // Observable list for products in this category
  var isLoading = true.obs; // Observable loading state
  final int categoryId; // The ID of the category for which to fetch products

  CategoryProductsController(this.categoryId); // Constructor accepting category ID

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Fetch products on initialization
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final products = await ApiService().fetchProductsByCategory(categoryId); // Fetching products by category
      productList.value = products.items; // Update observable product list
    } catch (e) {
      // Handle any errors that occur during API calls
      print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }
}
