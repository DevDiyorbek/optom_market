import 'package:get/get.dart';
import 'package:optom_market/data/models/product_model.dart';
import '../../../data/datasources/http_service.dart';
import '../../../data/models/product_list_model.dart';

class ShopPageController extends GetxController {
  var productList = <ProductModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    isLoading(true);
    try {
      final ProductListModel fetchedProducts = await ApiService().fetchProducts();
      productList.value = fetchedProducts.items; // Update observable list
    } finally {
      isLoading(false);
    }
  }

  void refreshProducts() {
    fetchProducts(); // Call fetch again on pull down refresh
  }
}
