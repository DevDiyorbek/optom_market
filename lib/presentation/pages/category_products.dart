import 'package:flutter/material.dart';
import 'package:optom_market/data/models/category_model.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({super.key, required ProductCategoryModel category});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
