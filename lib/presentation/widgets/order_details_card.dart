import 'package:flutter/material.dart';
import 'package:optom_market/data/models/OrderResponce.dart';

class OrderDetailCard extends StatelessWidget {
  final OrderDetail orderDetail;

  const OrderDetailCard({
    super.key,
    required this.orderDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Product Image
                Image.network(
                  orderDetail.product.images[0].url, // Assume images is not empty
                  width: 70.0,
                  height: 70.0,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10.0),
                // Product Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderDetail.product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Quantity: ${orderDetail.quantity}'),
                    ],
                  ),
                ),
                Text(
                  'Price: \$${(orderDetail.product.price * orderDetail.quantity).toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

          ],
        ),
      ),
    );
  }
}
