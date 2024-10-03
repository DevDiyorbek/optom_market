import 'package:get/get.dart';
import '../../../data/datasources/order_service.dart';
import '../../../data/models/OrderResponce.dart';
import 'package:optom_market/utility/LogServices.dart';

class OrderHistoryController extends GetxController {
  final OrderService orderService = OrderService();

  // Observable fields
  var orderList = <OrderResponse>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderHistory(); // Automatically fetch order history on initialization
  }

  // Method to fetch order history
  Future<void> fetchOrderHistory() async {
    isLoading.value = true; // Set loading state to true
    try {
      // Fetch the orders
      List<OrderResponse> response = await orderService.orderHistory();
      orderList.value = response; // Update the observable list
      LogService.w(response.toString()); // Log the response for debugging
    } catch (e) {
      print('Failed to fetch order history: $e'); // Print out any errors
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }

  // New method to refresh order history
  Future<void> refreshOrderHistory() async {
    await fetchOrderHistory(); // Call the fetch method to refresh orders
  }
}
