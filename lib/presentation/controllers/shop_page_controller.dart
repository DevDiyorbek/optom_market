import 'package:get/get.dart';
import 'package:optom_market/data/models/product_model.dart';
import '../../../data/datasources/http_service.dart';
import '../../../data/models/product_list_model.dart';

class ShopPageController extends GetxController {
  var productList = <ProductModel>[].obs;
  var filteredProductList = <ProductModel>[].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;
  var hasMoreItems = true.obs;
  var searchQuery = ''.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    isLoading(true);
    currentPage.value = 1;
    hasMoreItems.value = true;
    try {
      final ProductListModel fetchedProducts = await _apiService.fetchProducts(currentPage.value);
      productList.value = fetchedProducts.items;
      applySearch();
    } catch (e) {
      print('Error fetching products: $e');
      // Handle error (e.g., show error message to user)
    } finally {
      isLoading(false);
    }
  }

  void loadMoreProducts() async {
    if (!isLoading.value && hasMoreItems.value) {
      isLoading(true);
      try {
        final ProductListModel fetchedProducts = await _apiService.fetchProducts(currentPage.value + 1);
        if (fetchedProducts.items.isNotEmpty) {
          productList.addAll(fetchedProducts.items);
          currentPage++;
          applySearch();
        } else {
          hasMoreItems(false);
        }
      } catch (e) {
        print('Error loading more products: $e');
        // Handle error (e.g., show error message to user)
      } finally {
        isLoading(false);
      }
    }
  }

  void refreshProducts() {
    fetchProducts();
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    applySearch();
  }

  void applySearch() {
    if (searchQuery.isEmpty) {
      filteredProductList.value = productList;
    } else {
      filteredProductList.value = productList.where((product) =>
          product.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
  }
}
