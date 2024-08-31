import 'package:optom_market/data/models/product_model.dart';

class ProductListModel {
  final List<ProductModel> items;
  final int total;
  final int page;
  final int size;
  final int pages;
  final ProductListLinks links;

  ProductListModel({
    required this.items,
    required this.total,
    required this.page,
    required this.size,
    required this.pages,
    required this.links,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> productItems = json['items'];
    final productList = productItems.map((item) => ProductModel.fromJson(item)).toList();

    return ProductListModel(
      items: productList,
      total: json['total'],
      page: json['page'],
      size: json['size'],
      pages: json['pages'],
      links: ProductListLinks.fromJson(json['links']),
    );
  }
}

class ProductListLinks {
  final String first;
  final String last;
  final String self;
  final String? next;
  final String? prev;

  ProductListLinks({
    required this.first,
    required this.last,
    required this.self,
    required this.next,
    this.prev,
  });

  factory ProductListLinks.fromJson(Map<String, dynamic> json) {
    return ProductListLinks(
      first: json['first'],
      last: json['last'],
      self: json['self'],
      next: json['next'],
      prev: json['prev'],
    );
  }
}

// You'll also need the Product, ProductImage, and ProductCategory models (from the previous response)
// Define those models as well if you haven't already.
