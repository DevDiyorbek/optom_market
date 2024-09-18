import 'package:get/get.dart';

import '../../data/datasources/order_service.dart';

class CheckoutController extends GetxController {
  final OrderService orderService = OrderService();

  var address = ''.obs;
  var paymentMethod = 'Cash'.obs;
  var totalCost = 0.0.obs;

  void setAddress(String newAddress) {
    address.value = newAddress;
  }

  void setPaymentMethod(String method) {
    paymentMethod.value = method;
  }

  void setTotalCost(double cost) {
    totalCost.value = cost;
  }

  void placeOrder() {
    orderService.sendOrders(shippingAddress: address.value);
    print("Order is sent to address: ${address.value}");
  }
}
