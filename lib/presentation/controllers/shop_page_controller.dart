import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:optom_market/data/models/product_model.dart';
import '../../../data/datasources/http_service.dart';
import '../../../data/models/product_list_model.dart';
import '../../utility/LogServices.dart';

class ShopPageController extends GetxController {
  var productList = <ProductModel>[].obs;
  var filteredProductList = <ProductModel>[].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;
  var hasMoreItems = true.obs;
  var searchQuery = ''.obs;
  var isFiltered = false.obs;

  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final RxString selectedSortBy = 'name'.obs;
  final RxString selectedSortOrder = 'asc'.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();

    // Sync TextEditingController and searchQuery
    textEditingController.addListener(() {
      searchQuery.value = textEditingController.text;
    });

    // Debouncing similar effect through search query
    debounce(searchQuery, (_) => applySearch(searchQuery.value),
        time: const Duration(milliseconds: 500));
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  void fetchProducts() async {
    isLoading(true);
    currentPage.value = 1;
    hasMoreItems.value = true;

    try {
      final ProductListModel fetchedProducts =
          await _apiService.fetchProducts(currentPage.value);

      productList.assignAll(fetchedProducts.items);
      filteredProductList.assignAll(fetchedProducts.items);
    } catch (e) {
      LogService.e('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  void loadMoreProducts() async {
    if (isLoading.value ||
        !hasMoreItems.value ||
        filteredProductList.length < productList.length ||
        isFiltered.value) {
      return;
    }

    isLoading(true);
    try {
      final ProductListModel fetchedProducts =
          await _apiService.fetchProducts(currentPage.value + 1);

      if (fetchedProducts.items.isNotEmpty) {
        productList.addAll(fetchedProducts.items);
        filteredProductList.addAll(fetchedProducts.items);
        currentPage.value++;
      } else {
        hasMoreItems(false);
      }
    } catch (e) {
      LogService.e('Error loading more products: $e');
    } finally {
      isLoading(false);
    }
  }

  void resetFiltersAndFetch() {
    isFiltered(false);
    searchQuery.value = '';
    textEditingController.clear();
    minPriceController.clear();
    maxPriceController.clear();
    selectedSortBy.value = 'name';
    selectedSortOrder.value = 'asc';
    fetchProducts();
  }

  void refreshProducts() {
    textEditingController.clear();
    fetchProducts();
  }


  void applySearch(String value) async {
    // final query = textEditingController.text.toLowerCase().trim();
    if (value.isEmpty) {
      filteredProductList.assignAll(productList);
      isFiltered(false);
      return;
    }
    isLoading(true);
    isFiltered(true);
    try {
      final searchedProductListModel = await filterProducts(
        name: value,
      );
      if (searchedProductListModel != null) {
        filteredProductList.assignAll(searchedProductListModel.items);
      }
    } catch (e) {
      LogService.e('Error applying filters: $e');
    } finally {
      isLoading(false);
    }

  }

  void applyFilters() async {
    final minPrice = int.tryParse(minPriceController.text) ?? 0;
    final maxPrice = int.tryParse(maxPriceController.text) ?? double.infinity.toInt();

    isLoading(true);
    isFiltered(true);

    try {
      final filteredProductListModel = await filterProducts(
        sortBy: selectedSortBy.value,
        sortOrder: selectedSortOrder.value,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );

      if (filteredProductListModel != null) {
        filteredProductList.assignAll(filteredProductListModel.items);
      }
    } catch (e) {
      LogService.e('Error applying filters: $e');
    } finally {
      isLoading(false);
      Get.back();
    }
  }

  Future<ProductListModel?> filterProducts({
    String? name,
    String sortBy = 'id',
    String sortOrder = 'desc',
    int? minPrice,
    int? maxPrice,
  }) async {
    try {
      final ProductListModel productList = await _apiService.filterProducts(
        name: name,
        sortBy: sortBy,
        sortOrder: sortOrder,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );
      return productList;
    } catch (e) {
      LogService.e('Error filtering products: $e');
      return null;
    }
  }
}
