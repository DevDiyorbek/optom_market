import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optom_market/data/datasources/cart_service.dart';
import 'package:optom_market/presentation/controllers/cart_controller.dart';
import 'package:optom_market/presentation/widgets/snackbar_widget.dart';
import '../../../data/models/product_model.dart';
import '../../controllers/product_details_controller.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Get.create<ProductDetailsController>(() => ProductDetailsController());
    final ProductDetailsController productDetailsController =
        Get.find<ProductDetailsController>();
    final cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F3F2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.only(bottom: 50),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF2F3F2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
              child: Image.network(
                product.images.isNotEmpty
                    ? product.images.first.url
                    : 'https://via.placeholder.com/100',
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error_outline);
                },
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            flex: 12,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                              ),
                              color: productDetailsController
                                          .productQuantity.value >
                                      1
                                  ? Colors
                                      .green // Change color to green if quantity is greater than 1
                                  : Colors.grey,
                              // Change color to grey if quantity is 1
                              onPressed: () {
                                productDetailsController.decreaseQuantity();
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 15, top: 10, right: 15, bottom: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Text(
                                productDetailsController.productQuantity.value
                                    .toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              color: Colors.green,
                              // Always set this to green
                              onPressed: () {
                                productDetailsController.increaseQuantity();
                              },
                            ),
                          ],
                        ),
                      ),
                      Obx(() => Text(
                            "${(product.price * productDetailsController.productQuantity.value).toStringAsFixed(2)} so'm",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Product detail',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      Text(product.description)
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  const Divider(),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 35),
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            alignment: AlignmentDirectional.centerStart,
                            backgroundColor: const Color(0xFF37C537),
                          ),
                          onPressed: () async {
                            int productId = product.id;
                            int quantity = productDetailsController.productQuantity.value;
                            await CartService().addProductToCart(productId, quantity);
                            cartController.refreshCartItems();
                            showCustomSnackbar(context, "${product.name} added to cart successfully");
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: const Text(
                              'Add to Cart',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
