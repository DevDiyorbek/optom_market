import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/order_history_controller.dart';
import '../../widgets/order_history_card.dart';

class OrdersHistory extends StatelessWidget {
  const OrdersHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderHistoryController controller = Get.put(OrderHistoryController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.orderList.isEmpty) {
          return const Center(child: Text('No orders found'));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.refreshOrderHistory(); // Call the refresh method on pull-to-refresh
            },
            child: ListView.builder(
              itemCount: controller.orderList.length,
              itemBuilder: (context, index) {
                final order = controller.orderList[index];
                return OrderHistoryCard(
                  order: order,
                );
              },
            ),
          );
        }
      }),
    );
  }
}
