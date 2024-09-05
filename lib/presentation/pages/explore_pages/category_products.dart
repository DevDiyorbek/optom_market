import 'package:flutter/material.dart';
import 'package:optom_market/data/models/category_model.dart';

import '../../../data/datasources/http_service.dart';
import '../../../data/models/product_list_model.dart';
import '../../widgets/product_card.dart';

class CategoryProducts extends StatefulWidget {
  final ProductCategoryModel category;

  const CategoryProducts({super.key, required this.category});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  late Future<ProductListModel> _productList;
  @override
  void initState() {
    super.initState();
    _productList = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.category.name), // Display the category name
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () {
              // Handle filter button press
              // You can show a filter dialog or navigate to a filter screen
            },
          ),
        ],
      ),
      body: Expanded(
        child: FutureBuilder<ProductListModel>(
          future: _productList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading products'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No products available'));
            } else {
              final productList = snapshot.data!;
              // return productCard(productList.items[0], context);

              return ListView.builder(
                itemCount: (productList.items.length / 2).ceil(), // Calculate the number of rows
                itemBuilder: (context, rowIndex) {
                  final index1 = rowIndex * 2;
                  final index2 = index1 + 1;
                  return Row(
                    children: [
                      Expanded(
                        child: productCard(productList.items[index1], context),
                      ),
                      if (index2 < productList.items.length)
                        Expanded(
                          child: productCard(productList.items[index2], context),
                        ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
