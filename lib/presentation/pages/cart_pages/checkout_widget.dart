import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optom_market/presentation/controllers/cart_controller.dart';

import '../../controllers/checkout_controller.dart';

class CheckoutWidget extends StatefulWidget {
  final String initialDeliveryAddress;
  final double initialTotalCost;

  const CheckoutWidget({
    super.key,
    required this.initialDeliveryAddress,
    required this.initialTotalCost,
  });

  @override
  State<CheckoutWidget> createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  late TextEditingController addressController;
  late CheckoutController checkoutController;
  late CartController cartController;

  @override
  void initState() {
    super.initState();
    checkoutController = Get.put(CheckoutController());
    cartController = Get.put(CartController());
    addressController =
        TextEditingController(text: widget.initialDeliveryAddress);
    checkoutController.address.value = widget.initialDeliveryAddress;
    checkoutController.totalCost.value = widget.initialTotalCost;
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Checkout',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Delivery Address:'),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: TextField(
                        controller: addressController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          checkoutController.setAddress(value);
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Payment Method:'),
                    Obx(() => DropdownButton<String>(
                          value: checkoutController.paymentMethod.value,
                          items: ['Cash', 'Card'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              checkoutController.setPaymentMethod(newValue);
                            }
                          },
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Cost:'),
                    Obx(() => Text(
                          '\$${checkoutController.totalCost.value.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (checkoutController.address.value.isNotEmpty) {
                    checkoutController.placeOrder();
                    cartController.refreshCartItems();
                    Future.delayed(const Duration(milliseconds: 400), () {
                      Get.back();
                    });
                  } else {
                    Get.snackbar(
                      'Error',
                      'Address cannot be empty',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
