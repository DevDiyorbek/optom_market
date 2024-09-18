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
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {
              // Handle filter button press
            },
          ),
        ],
      ),
      body: Obx(() {
        print(
            'Rebuilding Obx widget. Products: ${controller.productList.length}');
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.productList.isEmpty) {
          return const Center(child: Text('No products available'));
        } else {
          return ListView.builder(
            itemCount: (controller.productList.length / 2).ceil(),
            itemBuilder: (context, rowIndex) {
              final index1 = rowIndex * 2;
              final index2 = index1 + 1;
              return Row(
                children: [
                  Expanded(
                    child: productCard(controller.productList[index1], context),
                  ),
                  if (index2 < controller.productList.length)
                    Expanded(
                      child:
                          productCard(controller.productList[index2], context),
                    ),
                ],
              );
            },
          );
        }
      }),
    );
  }
}
