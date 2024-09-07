import 'package:get/get.dart';

class FiltersController extends GetxController {

  var isEggsSelected = false.obs;
  var isNoodlesSelected = false.obs;

  // Price range fields
  var minPrice = ''.obs;
  var maxPrice = ''.obs;

  // Managing order selection
  var selectedOrderBy = ''.obs;

  // Method to apply filters
  void applyFilters() {
    // Logic to apply filters can be implemented here
    print('Filters Applied:');
    print('Eggs Selected: $isEggsSelected');
    print('Noodles Selected: $isNoodlesSelected');
    print('Min Price: $minPrice');
    print('Max Price: $maxPrice');
    print('Order By: $selectedOrderBy');
    // You can also implement a way to pass these filters back or to another page
  }
}
