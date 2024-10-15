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
          builder: (context) => CategoryProducts(category: category),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.all(8),
      width: 175,
      height: 175, // Slightly increased height to accommodate text better
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC6FFC1), Color(0xFFD4EDDA)], // Gradient for aesthetically pleasing effect
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4), // Shadow below the card
          ),
        ],
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between elements
        crossAxisAlignment: CrossAxisAlignment.center, // Center align for better symmetry
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0), // Rounding the image's corners
              child: Image.network(
                category.imageUrl.isNotEmpty
                    ? category.imageUrl
                    : 'https://via.placeholder.com/100', // Use a better placeholder if needed
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300], // Placeholder color
                    child: const Icon(Icons.error_outline, color: Colors.red), // Error icon
                  );
                },
              ),
            ),
          ),
          Text(
            category.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16, // Increased font size for better readability
              color: Colors.black, // Text color for better visibility
              overflow: TextOverflow.ellipsis, // Prevent overflow for long text
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
