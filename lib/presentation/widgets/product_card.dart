import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:optom_market/data/models/product_model.dart';
import 'package:optom_market/presentation/pages/shop_pages/product_details.dart';
import '../../data/datasources/cart_service.dart';

Widget productCard(ProductModel product, BuildContext context) {
  return Card(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Hero(
                  tag: 'product_image_${product.id}',
                  child: Image.network(
                    product.images.isNotEmpty
                        ? product.images.first.url
                        : 'https://via.placeholder.com/100',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error_outline, size: 50);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              flex: 1,
              child: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${NumberFormat('#,##0').format(product.price)} so\'m',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_shopping_cart, color: Colors.blue, size: 20),
                  onPressed: () async {
                    await CartService().addProductToCart(product.id, 1);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
