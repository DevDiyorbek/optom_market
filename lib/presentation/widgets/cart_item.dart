import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optom_market/presentation/controllers/cart_controller.dart';
import 'package:optom_market/utility/LogServices.dart';
import '../../data/models/cart_items_model.dart';
import '../controllers/cart_item_controller.dart';

//TODO work on items total value.

class CartItemWidget extends StatelessWidget {
  final CartItemsModel cartItem;
  final CartController cartController;
  late final CartItemController cartItemController;

  CartItemWidget({
    super.key,
    required this.cartItem,
    required this.cartController,
  }) {
    cartItemController = CartItemController(cartItem, cartItem.quantity);
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text(
              "Are you sure you want to remove this item from your cart?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                cartItemController.onRemove();
                cartController.refreshCartItems(); // Refresh cart items here
                LogService.w("Item removed successfully");
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = cartItemController.productQuantity.value;
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: cartItem.product.images.isNotEmpty
                        ? DecorationImage(
                            image:
                                NetworkImage(cartItem.product.images.first.url),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey[200],
                  ),
                  child: cartItem.product.images.isEmpty
                      ? const Icon(Icons.error_outline)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Obx(() => Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: cartItemController.decreaseQuantity,
                              ),
                              Text('${cartItemController.productQuantity.value}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: cartItemController.increaseQuantity,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        _showConfirmationDialog(context);
                      },
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Total:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(() => Text(
                              "${(cartItem.product.price * cartItemController.productQuantity.value).toStringAsFixed(2)} so'm",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
