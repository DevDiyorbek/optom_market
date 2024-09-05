import 'package:flutter/material.dart';
import 'package:optom_market/data/models/category_model.dart';
import 'package:optom_market/presentation/pages/explore_pages/category_products.dart';

Widget categoryCard(
  ProductCategoryModel category,
  BuildContext context,
) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => CategoryProducts(category:category),
            ),
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.all(8),
      width: 175,
      height: 190,
      decoration: BoxDecoration(
        //53B175
        color: Color(0xFFC6FFC1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.green,
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
                category.imageUrl.isNotEmpty
                    ? category.imageUrl
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
              category.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}
