import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../widgets/cart_item.dart';
import 'checkout_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, PageController? pageController});

  @override
  Widget build(BuildContext context) {
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
                          return CartItemWidget(
                              cartItem: cartItem,
                              cartController: cartController);
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
                        onPressed: () async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          );

                          // Fetch the initial address asynchronously
                          String initialAddress;
                          try {
                            initialAddress = await cartController.getInitialAddress();
                          } catch (e) {
                            initialAddress =''; // Default to empty if there's an error
                            print("Error fetching address: $e");
                          }

                          // Dismiss the loading indicator
                          Navigator.pop(context);

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              double totalPrice = cartController.calculateTotalPrice();
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 2 / 3,
                                child: CheckoutWidget(
                                  initialTotalCost: totalPrice,
                                  initialDeliveryAddress: initialAddress,
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
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
                    Obx(
                      () {
                        double totalPrice =
                            cartController.calculateTotalPrice();
                        return Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                totalPrice.toStringAsFixed(2),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "so'm",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        );
                      },
                    ),
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
