import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 45,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(7)),
      child: const TextField(
        style: TextStyle(color: Colors.black87),
        // controller: searchController.searchController,
        decoration: InputDecoration(
            hintText: "Search",
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            )),
      ),
    );
  }
}
