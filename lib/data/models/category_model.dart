
class ProductCategory {
  final int id;
  final String name;
  final String imageUrl;

  ProductCategory({required this.id, required this.name, required this.imageUrl});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
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