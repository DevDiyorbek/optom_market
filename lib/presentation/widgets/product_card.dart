import 'package:flutter/material.dart';
import 'package:optom_market/data/models/product_model.dart';
import 'package:optom_market/presentation/pages/product_details.dart';

Widget productCard(
    Product product,
    BuildContext context,
    ) {
  return GestureDetector(
    onTap: () {
      // Navigate to ProductDetails screen when the card is pressed
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductDetails(product:product), // Pass the product to the details screen
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.all(8),
      width: 150,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Center(
              child: Image.network(
                product.images.isNotEmpty
                    ? product.images.first.url
                    : 'https://via.placeholder.com/100',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error_outline);
                },
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Flexible(
            flex: 1,
            child: Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8.0),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.price.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Icon(
                  Icons.add_circle_sharp,
                  color: Colors.green,
                  size: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
