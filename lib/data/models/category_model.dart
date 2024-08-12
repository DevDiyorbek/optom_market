
class ProductCategoryModel {
  final int id;
  final String name;
  final String imageUrl;

  ProductCategoryModel({required this.id, required this.name, required this.imageUrl});

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
    };
  }
}