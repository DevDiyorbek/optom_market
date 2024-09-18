import 'package:get/get.dart';
import 'package:optom_market/data/models/product_model.dart';
import 'package:optom_market/data/datasources/http_service.dart';

class CategoryProductsController extends GetxController {
  final int categoryId;
  final ApiService _apiService = ApiService();
  var productList = <ProductModel>[].obs;
  var isLoading = true.obs;

  CategoryProductsController(this.categoryId);

  @override
  void onInit() {
    fetchProductsByCategory();
    super.onInit();
  }

  void fetchProductsByCategory() async {
    isLoading(true);
    try {
      final products = await _apiService.fetchProductsByCategory(categoryId);
      productList.assignAll(products.items);
    } catch (error) {
      print('Error fetching products for category $categoryId: $error');
    } finally {
      isLoading(false);
    }
  }
}
