import 'package:get/get.dart';
import '../../data/datasources/http_service.dart';
import '../../data/models/category_model.dart';

class ExplorePageController extends GetxController {
  var categoryList = <ProductCategoryModel>[].obs; // Observable list for categories
  var isLoading = true.obs; // Observable loading state

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Fetch categories from the API
  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      categoryList.value = await ApiService().fetchCategories();
    } catch (e) {
      // You can handle errors here (e.g., logging)
      print('Error fetching categories: $e');
    } finally {
      isLoading(false);
    }
  }
}
