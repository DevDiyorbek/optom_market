import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/category_model.dart';
import '../../controllers/category_products_controller.dart';
import '../../widgets/product_card.dart';

class CategoryProducts extends StatelessWidget {
  final ProductCategoryModel category;

  const CategoryProducts({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    print(
        'Building CategoryProducts for category: ${category.name} (ID: ${category.id})');

    final CategoryProductsController controller = Get.put(
      CategoryProductsController(category.id),
      tag: 'category_${category.id}',
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(category.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.productList.isEmpty) {
            return const Center(child: Text('No products available'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 2/3
              ),
              itemCount: controller.productList.length,
              itemBuilder: (context, index) {
                return productCard(controller.productList[index], context);
              },
            );
          }
        }),
      ),
    );
  }
}
