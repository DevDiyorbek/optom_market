import 'package:flutter/material.dart';
import 'package:optom_market/data/models/OrderResponce.dart';

import '../pages/account_pages/order_history_details.dart';

class OrderHistoryCard extends StatelessWidget {
  final OrderResponse order;

  const OrderHistoryCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    // Define a method to get the status color based on the order status
    Color? getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'delivering':
          return Colors.blue;
        case 'cancelled':
          return Colors.red;
        case 'delivered':
          return Colors.green;
        case 'approved':
          return Colors.amber;
        default:
          return Colors.black; // Default color if no match
      }
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ${order.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to OrderHistoryDetails page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderHistoryDetails(order: order),
                      ),
                    );
                  },
                  child: const Text(
                    'Show Order',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline, // Optional: underline text to indicate it's clickable
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8.0),

            Text(
              'Total Price: \$${order.orderAmount.toStringAsFixed(2)} (${order.orderDetails.length} items)',
              style: const TextStyle(fontSize: 16.0),
            ),

            const Divider(height: 20.0, thickness: 1.0, color: Colors.grey),

            Row(
              children: [
                const Text("Status: ", style: TextStyle(fontWeight: FontWeight.bold),),
                Text(
                  order.orderStatus,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontStyle: FontStyle.italic,
                    color: getStatusColor(order.orderStatus), // Use the method to set the color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
