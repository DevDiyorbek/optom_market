import 'package:flutter/material.dart';
import 'package:optom_market/data/models/OrderResponce.dart';

import '../../widgets/order_details_card.dart';

class OrderHistoryDetails extends StatelessWidget {
  final OrderResponse order;

  const OrderHistoryDetails({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order ID: ${order.id}',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),

            // List of order detail cards
            Expanded(
              child: ListView.builder(
                itemCount: order.orderDetails.length,
                itemBuilder: (context, index) {
                  final orderDetail = order.orderDetails[index];
                  return OrderDetailCard(orderDetail: orderDetail);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
