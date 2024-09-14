import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optom_market/data/datasources/order_service.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, PageController? pageController});

  @override
  Widget build(BuildContext context) {
    final OrderService orderService = OrderService();
    final CartController cartController = Get.put(CartController());
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Divider(),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    cartController.refreshCartItems();
                  },
                  child: Obx(() {
                    if (cartController.cartItems.isEmpty) {
                      return const Center(child: Text('Your cart is empty.'));
                    } else {
                      return ListView.builder(
                        itemCount: cartController.cartItems.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartController.cartItems[index];
                          return CartItemWidget(cartItem: cartItem, cartController: cartController); // Pass it here
                        },
                      );
                    }
                  }),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 20.0),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          orderService.sendOrders(shippingAddress: "Uchlola");
                          // Handle checkout action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          // Change color as needed
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Go to Checkout',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // Total Price Text
                    Obx(() {
                      double totalPrice = cartController.cartItems.fold(
                        0.0,(sum, item) =>
                        sum + (item.itemCost * item.quantity), // Make sure to get the current quantity
                      );
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          '\$${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
