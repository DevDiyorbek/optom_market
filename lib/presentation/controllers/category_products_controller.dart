import 'package:get/get.dart';
import 'package:optom_market/data/models/product_model.dart';
import 'package:optom_market/data/datasources/http_service.dart';
import 'package:optom_market/utility/LogServices.dart';

class CategoryProductsController extends GetxController {
  final int categoryId;
  final ApiService _apiService = ApiService();
  var productList = <ProductModel>[].obs;
  var isLoading = true.obs;

  CategoryProductsController(this.categoryId);

  @override
  void onInit() {
    super.onInit();
    fetchProductsByCategory();
  }


  void fetchProductsByCategory() async {
    isLoading(true);
    try {
      final products = await _apiService.fetchProductsByCategory(categoryId);
      print('Fetched products: $products'); // Debug output
      productList.assignAll(products);
    } catch (error) {
      print('Error fetching products for category $categoryId: $error');
    } finally {
      isLoading(false);
    }
  }


}
