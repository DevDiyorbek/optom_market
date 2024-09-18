import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/shop_page_controller.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ShopPageController shopController = Get.find<ShopPageController>();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 45,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(7)),
      child: TextField(
        style: const TextStyle(color: Colors.black87),
        onChanged: (value) {
          shopController.searchProducts(value);
        },
        decoration: const InputDecoration(
          hintText: "Search",
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
          icon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
