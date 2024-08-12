import 'category_model.dart';
import 'image_model.dart';

class ProductModel {
  final String name;
  final int quantity;
  final String description;
  final double price;
  final int categoryId;
  final int id;
  final List<ProductImageModel> images;
  final ProductCategoryModel category;
  final int soldQuantity;

  ProductModel({
    required this.name,
    required this.quantity,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.id,
    required this.images,
    required this.category,
    required this.soldQuantity,
  });

  // Factory method to create a Product instance from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      quantity: json['quantity'],
      description: json['description'],
      price: json['price'].toDouble(),
      categoryId: json['category_id'],
      id: json['id'],
      images: (json['images'] as List)
          .map((imageJson) => ProductImageModel.fromJson(imageJson))
          .toList(),
      category: ProductCategoryModel.fromJson(json['category']),
      soldQuantity: json['sold_quantity'],
    );
  }

  // Convert Product instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'description': description,
      'price': price,
      'category_id': categoryId,
      'id': id,
      'images': images.map((image) => image.toJson()).toList(),
      'category': category.toJson(),
      'sold_quantity': soldQuantity,
    };
  }
}